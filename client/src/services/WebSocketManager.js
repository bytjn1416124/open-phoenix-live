/**
 * WebSocket manager for handling real-time communication
 */
export class WebSocketManager {
    constructor(url) {
        this.url = url;
        this.ws = null;
        this.isConnected = false;
        this.reconnectAttempts = 0;
        this.maxReconnectAttempts = 5;
        this.reconnectDelay = 1000;

        // Callback stores
        this.messageCallbacks = new Set();
        this.videoCallbacks = new Set();
        this.audioCallbacks = new Set();
        this.connectCallbacks = new Set();
        this.disconnectCallbacks = new Set();

        this.connect();
    }

    connect() {
        try {
            this.ws = new WebSocket(this.url);

            this.ws.onopen = () => {
                console.log('WebSocket connected');
                this.isConnected = true;
                this.reconnectAttempts = 0;
                this.reconnectDelay = 1000;
                this.connectCallbacks.forEach(cb => cb());
            };

            this.ws.onclose = () => {
                console.log('WebSocket disconnected');
                this.isConnected = false;
                this.disconnectCallbacks.forEach(cb => cb());
                this.attemptReconnect();
            };

            this.ws.onerror = (error) => {
                console.error('WebSocket error:', error);
            };

            this.ws.onmessage = (event) => {
                this.handleMessage(event.data);
            };

        } catch (error) {
            console.error('Error creating WebSocket:', error);
            this.attemptReconnect();
        }
    }

    attemptReconnect() {
        if (this.reconnectAttempts < this.maxReconnectAttempts) {
            this.reconnectAttempts++;
            console.log(`Attempting reconnect ${this.reconnectAttempts}/${this.maxReconnectAttempts}`);
            
            setTimeout(() => {
                this.connect();
            }, this.reconnectDelay);
            
            // Exponential backoff
            this.reconnectDelay = Math.min(this.reconnectDelay * 2, 30000);
        } else {
            console.error('Max reconnection attempts reached');
        }
    }

    handleMessage(data) {
        if (data instanceof Blob) {
            // Handle binary data (video/audio)
            data.arrayBuffer().then(buffer => {
                const dataView = new DataView(buffer);
                const type = dataView.getUint8(0);
                const content = buffer.slice(1);

                if (type === 0) { // Video frame
                    this.videoCallbacks.forEach(cb => cb(content));
                } else if (type === 1) { // Audio data
                    this.audioCallbacks.forEach(cb => cb(content));
                }
            });
        } else {
            // Handle text data
            try {
                const message = JSON.parse(data);
                this.messageCallbacks.forEach(cb => cb(message));
            } catch (error) {
                console.error('Error parsing message:', error);
            }
        }
    }

    sendMessage(message) {
        if (this.isConnected) {
            this.ws.send(JSON.stringify(message));
        } else {
            console.warn('Cannot send message: WebSocket not connected');
        }
    }

    sendAudio(audioData) {
        if (this.isConnected) {
            // Create message with type header
            const buffer = new ArrayBuffer(audioData.length * 2 + 1);
            const view = new DataView(buffer);
            
            // Set message type (1 for audio)
            view.setUint8(0, 1);
            
            // Convert Float32Array to Int16Array for compression
            const samplesInt16 = new Int16Array(audioData.length);
            for (let i = 0; i < audioData.length; i++) {
                // Convert from [-1, 1] to [-32767, 32767]
                samplesInt16[i] = Math.max(-32767, Math.min(32767, audioData[i] * 32767));
            }
            
            // Copy samples to buffer after type header
            new Int16Array(buffer, 1).set(samplesInt16);
            
            this.ws.send(buffer);
        }
    }

    onMessage(callback) {
        this.messageCallbacks.add(callback);
        return () => this.messageCallbacks.delete(callback);
    }

    onVideoFrame(callback) {
        this.videoCallbacks.add(callback);
        return () => this.videoCallbacks.delete(callback);
    }

    onAudio(callback) {
        this.audioCallbacks.add(callback);
        return () => this.audioCallbacks.delete(callback);
    }

    onConnect(callback) {
        this.connectCallbacks.add(callback);
        if (this.isConnected) {
            callback();
        }
        return () => this.connectCallbacks.delete(callback);
    }

    onDisconnect(callback) {
        this.disconnectCallbacks.add(callback);
        return () => this.disconnectCallbacks.delete(callback);
    }

    disconnect() {
        if (this.ws) {
            this.ws.close();
            this.ws = null;
        }
        this.messageCallbacks.clear();
        this.videoCallbacks.clear();
        this.audioCallbacks.clear();
        this.connectCallbacks.clear();
        this.disconnectCallbacks.clear();
    }
}