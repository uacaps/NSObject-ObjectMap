# TravisCI/script.sh

#!/bin/sh
set -e

xctool -project Tests/UnitTests.xcodeproj -scheme UnitTests -sdk iphonesimulator test