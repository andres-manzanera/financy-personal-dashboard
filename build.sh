#!/bin/bash
echo "Installing Flutter..."
git clone https://github.com/flutter/flutter.git -b 3.24.5 --depth 1
export PATH="$PATH:`pwd`/flutter/bin"
flutter config --no-analytics
echo "Getting dependencies..."
flutter pub get
echo "Building Web..."
flutter build web --release --no-tree-shake-icons
