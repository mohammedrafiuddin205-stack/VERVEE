#!/bin/bash
set -e

echo "Starting Android SDK setup for VERVE Codespace..."

# Define Android Home path inside the Codespace container
export ANDROID_HOME=/home/vscode/android-sdk
mkdir -p $ANDROID_HOME/cmdline-tools

# Download Android Command Line Tools (latest stable for Linux)
echo "Downloading Android Command Line Tools..."
wget -q https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip -O cmdline-tools.zip

# Unzip and set up standard directory structure
unzip -q cmdline-tools.zip -d $ANDROID_HOME/cmdline-tools
rm cmdline-tools.zip

# The tools must be inside a folder named 'latest' to work correctly without warnings
mv $ANDROID_HOME/cmdline-tools/cmdline-tools $ANDROID_HOME/cmdline-tools/latest

# Update temporary PATH for the installation process
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools

# Persist environment variables in .bashrc for the integrated terminal
echo "export ANDROID_HOME=$ANDROID_HOME" >> /home/vscode/.bashrc
echo "export PATH=\$PATH:\$ANDROID_HOME/cmdline-tools/latest/bin:\$ANDROID_HOME/platform-tools" >> /home/vscode/.bashrc

# Accept all SDK licenses non-interactively
echo "Accepting Android licenses..."
yes | sdkmanager --licenses > /dev/null

# Install Platform Tools, Build Tools 34, and Target SDK 34
echo "Installing SDK packages (Platform 34, Build Tools 34.0.0)..."
sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"

echo "✅ Android SDK setup complete! Ready to build VERVE."