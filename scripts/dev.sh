#!/bin/bash

# Exit on error
set -e

# Load environment variables
set -a
source .env
set +a

# Check if virtual environment is activated
if [[ "$VIRTUAL_ENV" == "" ]]; then
    echo "Please activate virtual environment first"
    echo "Run: source venv/bin/activate"
    exit 1
fi

# Start development servers
echo "Starting development servers..."

# Start Redis (if not running)
redis-server --daemonize yes

# Start backend services
python -m server.stt_service & 
STT_PID=$!

python -m server.llm_service &
LLM_PID=$!

python -m server.tts_service &
TTS_PID=$!

python -m server.rendering_service &
RENDER_PID=$!

# Start main server
python -m server.main_server &
MAIN_PID=$!

# Start React development server
cd client
npm start &
CLIENT_PID=$!

# Cleanup function
cleanup() {
    echo "Shutting down services..."
    kill $STT_PID $LLM_PID $TTS_PID $RENDER_PID $MAIN_PID $CLIENT_PID
    redis-cli shutdown
    exit 0
}

# Register cleanup function
trap cleanup SIGINT SIGTERM

# Wait for any process to exit
wait -n

# Exit with status of process that exited first
exit $?