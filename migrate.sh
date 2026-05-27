#!/bin/bash

# Exit immediately if any command fails
set -e

echo "Starting migration of 'app' folder contents to root..."

# 1. Move everything from app/ to the current directory
# We use a loop to avoid issues with hidden files
shopt -s dotglob
mv app/* .
shopt -u dotglob

# 2. Clean up the empty app directory
rm -rf app

# 3. Clean Flutter/Gradle/CocoaPods build artifacts
# These store absolute paths and must be regenerated
echo "Cleaning build artifacts..."
flutter clean
rm -rf ios/Pods
rm -rf ios/Podfile.lock

# 4. Update dependencies
echo "Updating pubspec dependencies..."
flutter pub get

# 5. Fix iOS Pods
if [ -d "ios" ]; then
    echo "Reinstalling iOS pods..."
    cd ios
    pod install
    cd ..
fi

echo "Migration complete."
echo "Please verify your files, then run: git add . && git commit -m 'chore: restructure project to root'"
