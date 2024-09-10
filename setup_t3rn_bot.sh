#!/bin/bash

# Script to set up and run t3rn-bot

# Requirements check for Node.js and NPM
echo "Checking Node.js and NPM versions..."
node_version=$(node -v)
npm_version=$(npm -v)

if [[ "$node_version" < "v14" ]]; then
    echo "Node.js version must be v14 or later. Current version: $node_version"
    exit 1
fi

if [[ "$npm_version" < "6" ]]; then
    echo "NPM version must be v6 or later. Current version: $npm_version"
    exit 1
fi

echo "Node.js and NPM versions are sufficient."
echo "Node.js: $node_version, NPM: $npm_version"

# Clone the repository
echo "Cloning the t3rn-bot repository..."
git clone https://github.com/FEdanish/t3rn-bot.git

# Navigate to the t3rn-bot directory
cd t3rn-bot || { echo "Failed to enter t3rn-bot directory"; exit 1; }

# Install dependencies
echo "Installing dependencies..."
npm install

# Take private keys as input
echo "Please enter the private keys. Press Enter after each key. Type 'done' when finished:"

private_keys=()
while true; do
    read -r key
    if [[ $key == "done" ]]; then
        break
    fi
    private_keys+=("\"$key\"")
done

# Create privateKeys.json
echo "Creating privateKeys.json..."
echo "[" > privateKeys.json
echo "  ${private_keys[*]}" >> privateKeys.json
echo "]" >> privateKeys.json

echo "privateKeys.json created successfully with the provided private keys."

# Run the bot
echo "Starting the bot..."
node index.js
