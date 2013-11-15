#!/bin/sh
set -e

xctool ONLY_ACTIVE_ARCH=NO -project Tests/UnitTests.xcodeproj -scheme UnitTests -sdk iphonesimulator test