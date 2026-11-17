#!/usr/bin/env bash
# Yerel .mpp derlemesi: JDK 17 (AGP'nin jlink adımı JDK 27 ile patlıyor),
# Android SDK ve GitHub Packages kimliği ile.
#
# Kullanım: tools/build-mpp.sh [gradle görevi...]
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

export JAVA_HOME="${JAVA_HOME:-/opt/homebrew/opt/openjdk@17}"
export PATH="$JAVA_HOME/bin:$PATH"
export ANDROID_HOME="${ANDROID_HOME:-$HOME/Library/Android/sdk}"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export GITHUB_ACTOR="${GITHUB_ACTOR:-$(gh api user --jq .login)}"
export GITHUB_TOKEN="${GITHUB_TOKEN:-$(gh auth token)}"

if [ "$#" -eq 0 ]; then
    set -- :patches:buildAndroid
fi

cd "$ROOT/pixelboard-patches"
./gradlew "$@" --no-daemon

VERSION="$(grep -E '^version\s*=' gradle.properties | cut -d'=' -f2 | tr -d ' ')"
MPP="patches/build/libs/patches-${VERSION}.mpp"
if [ -f "$MPP" ]; then
    cp "$MPP" "$ROOT/patches/PixelBoard.mpp"
    echo "✅ $ROOT/patches/PixelBoard.mpp ($(shasum -a 256 "$ROOT/patches/PixelBoard.mpp" | cut -c1-16))"
fi
