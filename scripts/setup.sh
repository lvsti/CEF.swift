#!/bin/bash

set -ex

if [ -z "$(which 7z)" ]; then
    echo "ERROR: 7zip not found; brew install p7zip"
    exit 1
fi

if [ -z "$(which jq)" ]; then
    echo "ERROR: jq not found; brew install jq"
    exit 1
fi

if [ -z "$(which cmake)" ]; then
    echo "ERROR: cmake not found; brew install cmake"
    exit 1
fi

CEF_BRANCH=$(git rev-parse --abbrev-ref HEAD | cut -d_ -f2)

if [ "${CEF_BRANCH%_*}" != "cef" ]; then
    echo "ERROR: this script must be run from one of the cef_XXXX branches!"
    exit 1
fi

echo "preconditions have been met"
exit 0

# fetch CEF binary distribution package
CEF_BUILD_S3_KEY=$(curl https://cefbuilds.com |
                   scripts/cefbuilds.py -x --platforms=mac64 --branches=${CEF_BRANCH} - | \
                   jq '."'${CEF_BRANCH}'".mac64.s3key' | \
                   tr -d \")

CEFBUILD_TEMP=$(mktemp -d /tmp/cefbuild.XXX)
CEFBUILD_NAME=$(basename ${CEF_BUILD_S3_KEY})
CEFBUILD_TEMP_PATH="${CEFBUILD_TEMP}/${CEFBUILD_NAME}"
S3_BUCKET_URL="https://cefbuilds.s3.amazonaws.com"

curl "${S3_BUCKET_URL}/${CEF_BUILD_S3_KEY}" -o "${CEFBUILD_TEMP_PATH}"

CEFBUILD_BASE="${CEFBUILD_NAME%.*}"
CEFBUILD_EXT="${CEFBUILD_NAME##*.}"

if [ "${CEFBUILD_EXT}" == "7z" ]; then
    mkdir -p External
    7z x -oExternal "${CEFBUILD_TEMP_PATH}"
fi

rm -rf "${CEFBUILD_TEMP}"

if [ -e "External/cef_binary" ]; then
    rm -f External/cef_binary
fi

ln -s "${CEFBUILD_BASE}" External/cef_binary

# build the framework
pushd .

cd External/cef_binary
cmake -G Xcode
xcodebuild clean build -project cef.xcodeproj -scheme cefsimple -arch x86_64

popd
