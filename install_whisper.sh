#!/bin/bash

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "git is not installed. Please install it"
    exit 1
fi

# Check if c++ compiler is installed
if ! command -v g++ &> /dev/null; then
    echo "c++ compiler is not installed. Please install it"
    exit 1
fi

#Check if make is installed
if ! command -v make &> /dev/null; then
    echo "make is not installed. Please install it"
    exit 1
fi

# Check if xcode is installed
if ! command -v xcode-select &> /dev/null; then
    echo "xcode is not installed. Please install it"
    exit 1
fi

# Check if the whisper directory exists
if [ ! -d whisper.cpp ]; then
    # Create the whisper directory
    mkdir -p whisper.cpp

    # Clone the whisper repository
    git clone https://github.com/ggerganov/whisper.cpp.git

    # Change to the whisper directory
    cd whisper.cpp

    # Download the large model
    ./models/download-ggml-model.sh large

    # Build the whisper executable
    make

    cd ..

fi