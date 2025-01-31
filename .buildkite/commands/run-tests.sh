#!/bin/bash -eu

# Notice that:
#
# - We are using raw `xcodebuild` without extra tooling such as Fastlane,
#   `xcpretty`, or `xcbeautify`. This is an intentional compromise to keep the
#   setup lean, as adding any of those would require extra tooling and
#   ceremony in CI for what, right now, is merely a gain in log readability.
#
# - The iOS Simulator version is hardcoded in the script, unlike the Simulator
#   device, so we have a single source of truth. The downside is that the
#   syntax in the pipeline is less clear: a reader might ask where the iOS
#   version is set. As long as we only need to test against the latest iOS
#   version, that seems like a reasonable tradeoff to make it easier to move to
#   newer versions as they are released.
SIMULATOR_NAME=$1
SIMULATOR_VERSION='18.2'

xcodebuild clean test \
  -project 'XCUITestHelpers.xcodeproj' \
  -scheme 'XCUITestHelpers' \
  -destination "platform=iOS Simulator,name=$SIMULATOR_NAME,OS=$SIMULATOR_VERSION"
