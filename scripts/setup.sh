#!/usr/bin/env sh

set -e

if [ "${TRAVIS}" = "true" ]; then
    BRANCH="${TRAVIS_BRANCH}"
else
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
fi

if [ "${BRANCH%_*}" != "cef" ]; then
    echo "ERROR: this script must be run from one of the cef_XXXX branches!"
    exit 1
fi

CEF_BRANCH="${BRANCH##*_}"

if [ -z "$(which jq)" ]; then
    echo "ERROR: jq not found; brew install jq"
    exit 1
fi

if [ -z "$(which cmake)" ]; then
    echo "ERROR: cmake not found; brew install cmake"
    exit 1
fi

if [ -z "$(which xcpretty)" ]; then
    echo "ERROR: xcpretty not found; gem install xcpretty"
    exit 1
fi

if [ -z "$(pip list 2>/dev/null | grep lxml)" ]; then
    echo "ERROR: lxml not found; pip install lxml"
    exit 1
fi

# fetch CEF binary distribution package
echo "Fetching binary distribution..."
CEFBUILD_DESCRIPTOR=$(curl http://opensource.spotify.com/cefbuilds/index.html |
                      scripts/cefbuilds_spotify.py -x --platforms=macosx64 --branches=${CEF_BRANCH} - |
                      jq '."macosx64"."'${CEF_BRANCH}'"')

CEFBUILD_URL=$(echo ${CEFBUILD_DESCRIPTOR} | jq '.dists.standard' | tr -d '"')
CEFBUILD_VERSION=${CEF_BRANCH}'.'$(echo ${CEFBUILD_DESCRIPTOR} | jq '.delta' | tr -d '"')

CEFBUILD_TEMP=$(mktemp -d /tmp/cefbuild.XXX)
CEFBUILD_TEMP_PATH="${CEFBUILD_TEMP}/${CEFBUILD_VERSION}.tar.bz2"

curl "${CEFBUILD_URL}" -k -o "${CEFBUILD_TEMP_PATH}"

echo "Extracting package..."
mkdir -p External
tar xzf "${CEFBUILD_TEMP_PATH}" -C External
CEFBUILD_DIR_NAME=$(tar -tzf "${CEFBUILD_TEMP_PATH}" | head -1 | tr -d '/')

rm -rf "${CEFBUILD_TEMP}"

if [ -e "External/cef_binary" ]; then
    rm -f External/cef_binary
fi

ln -s "${CEFBUILD_DIR_NAME}" External/cef_binary

# build the framework
pushd .

cd External/cef_binary
cmake -G Xcode
set -o pipefail && xcodebuild clean build -project cef.xcodeproj -target "cefsimple Helper" -arch x86_64 -configuration Debug | xcpretty -c
set -o pipefail && xcodebuild clean build -project cef.xcodeproj -target "cefsimple Helper" -arch x86_64 -configuration Release | xcpretty -c

popd
