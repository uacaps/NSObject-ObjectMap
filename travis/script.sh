#!/bin/sh
set -e

xctool ARCHS=i386 ONLY_ACTIVE_ARCH=NO -project Tests/UnitTests.xcodeproj -scheme UnitTests -sdk iphonesimulator test