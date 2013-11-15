#!/bin/sh
set -e

xctool VALID_ARCHS=i386 CURRENT_ARCH=i386 ONLY_ACTIVE_ARCH=YES -project Tests/UnitTests.xcodeproj -scheme UnitTests -sdk iphonesimulator test