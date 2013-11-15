#!/bin/sh
set -e

xctool -project UnitTests.xcodeproj -scheme UnitTests -sdk iphonesimulator test