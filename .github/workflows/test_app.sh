#!/bin/bash

# code from https://engineering.talkdesk.com/test-and-deploy-an-ios-app-with-github-actions-44de9a7dcef6

set -eo pipefail

xcodebuild -workspace CamelCalculator.xcworkspace \
            -scheme CamelCalculator \
            -destination platform=iOS\ Simulator,OS=14.0,name=iPhone\ 12 \
            clean test | xcpretty