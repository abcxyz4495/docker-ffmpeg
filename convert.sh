#!/bin/bash

set -e  # Exit on any error

echo "Starting video conversion..."
echo "Input file: /videos/input.mp4"

# Check if input file exists
if [ ! -f /videos/input.mp4 ]; then
    echo "Error: Input file not found at /videos/input.mp4"
    exit 1
fi

echo "Converting to multiple resolutions..."

# Convert to different resolutions
for res in 144 360 480 720 1080; do
    echo "Converting to ${res}p..."
    ffmpeg -y -i /videos/input.mp4 \
        -vf scale=-2:${res} \
        -c:v libx264 -crf 23 -preset medium \
        -c:a aac -b:a 128k \
        /videos/output_${res}p.mp4 || {
            echo "Failed to convert to ${res}p"
            exit 1
        }
    echo "Successfully created ${res}p version"
done

echo "All conversions completed successfully!"
exit 0 