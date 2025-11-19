#!/usr/bin/env bash
set -euo pipefail

# Helper script to configure & build with vcpkg toolchain
# Usage: ./build-with-vcpkg.sh [additional cmake args]

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
BUILD_DIR="$ROOT_DIR/build"

if [ -z "${VCPKG_ROOT:-}" ]; then
  echo "VCPKG_ROOT is not set. Please set VCPKG_ROOT to your vcpkg root or pass -DCMAKE_TOOLCHAIN_FILE=<path> to cmake."
  echo "If you want quick setup, run:"
  echo "  git clone https://github.com/microsoft/vcpkg.git \$HOME/vcpkg"
  echo "  cd \$HOME/vcpkg && ./bootstrap-vcpkg.sh"
  exit 1
fi

TOOLCHAIN_FILE="$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake"
if [ ! -f "$TOOLCHAIN_FILE" ]; then
  echo "vcpkg toolchain file not found at $TOOLCHAIN_FILE"
  exit 1
fi

mkdir -p "$BUILD_DIR"
cmake -S "$ROOT_DIR" -B "$BUILD_DIR" -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN_FILE" "$@"
cmake --build "$BUILD_DIR" -- -j"$(nproc)"
