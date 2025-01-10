#!/bin/bash

set -e  # Exit on any error

# Check if input file was provided as argument
if [ $# -eq 0 ]; then
    echo "Error: Please provide the input video file"
    echo "Usage: $0 <input-video-file>"
    exit 1
fi

INPUT_FILE="$1"

# Check if input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: File '$INPUT_FILE' not found"
    exit 1
fi

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
    echo "Error: Docker is not running. Please start Docker first."
    exit 1
fi

# Check if docker-compose exists
if ! command -v docker compose &> /dev/null; then
    echo "Error: docker compose is not installed. Please install it first."
    exit 1
fi

# Copy input file to standard name
echo "Preparing input file..."
cp "$INPUT_FILE" input.mp4

echo "Starting video conversion..."

# Build and run the video converter
if ! docker compose up --build video-converter; then
    echo "Error: Failed to run docker compose"
    rm input.mp4  # Cleanup
    exit 1
fi

# Check if all output files exist
resolutions=("144" "360" "480" "720" "1080")
success=true

for res in "${resolutions[@]}"; do
    if [ ! -f "output_${res}p.mp4" ]; then
        echo "Error: output_${res}p.mp4 not found!"
        success=false
    else
        echo "Successfully created output_${res}p.mp4 ($(du -h output_${res}p.mp4 | cut -f1))"
    fi
done

# Clean up Docker containers and temporary input file
echo "Cleaning up..."
docker compose down
rm input.mp4

if [ "$success" = true ]; then
    echo "All video conversions completed successfully!"
    exit 0
else
    echo "Some video conversions failed!"
    exit 1
fi