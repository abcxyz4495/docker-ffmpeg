# Video Conversion using Docker and FFmpeg

This project demonstrates how to use Docker to convert a video to multiple resolutions using FFmpeg. The script will convert an input video file (`input.mp4`) to 144p, 360p, 480p, 720p, and 1080p resolutions. The converted files will be saved as `output_<resolution>p.mp4`.

## Requirements

- Docker
- docker-compose
- A video file (`input.mp4`) to be converted

## Files Overview

- `Dockerfile.ffmpeg`: Defines the Docker image based on the FFmpeg container, installs Bash, and sets up the conversion script.
- `convert.sh`: A script inside the Docker container that handles video conversion.
- `convert_video.sh`: A script that automates the entire process, including Docker setup and file management.

## Getting Started

### Prerequisites

Ensure you have Docker and Docker Compose installed on your machine. You can install them by following the official documentation:

- [Docker Installation](https://docs.docker.com/get-docker/)
- [Docker Compose Installation](https://docs.docker.com/compose/install/)

### Setup

1. Clone or download this repository to your local machine.
2. Navigate to the project directory:
   ```bash
   cd /path/to/video-conversion
