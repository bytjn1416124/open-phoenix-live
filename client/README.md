# OpenPhoenix-Live Client

## Overview
Client-side implementation of the OpenPhoenix-Live system.

## Directory Structure
```plaintext
client/
├── public/             # Static assets
│   └── index.html      # Main HTML file
├── cvi_app.js          # Main JS for WebRTC
└── src/                # React source code
```

## Components

### cvi_app.js
- WebRTC implementation
- Video stream management
- Real-time communication

### Features
- Real-time video chat
- Audio streaming
- UI controls
- Status indicators

## Dependencies
- Node.js 16+
- React 18+
- WebRTC API
- Socket.IO

## Setup
```bash
# Install dependencies
npm install

# Start development server
npm start

# Build for production
npm run build
```