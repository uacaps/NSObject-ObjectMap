#!/bin/sh
set -e

chmod +x travis
xctool -project Tests/UnitTests.xcodeproj -scheme UnitTests test