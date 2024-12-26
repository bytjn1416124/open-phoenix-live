import React, { useEffect, useRef, useState } from 'react';
import VideoInterface from './components/VideoInterface';
import ChatInterface from './components/ChatInterface';
import { WebSocketManager } from './services/WebSocketManager';

function App() {
    const [isConnected, setIsConnected] = useState(false);
    const [messages, setMessages] = useState([]);
    const wsManager = useRef(null);

    useEffect(() => {
        // Initialize WebSocket connection
        wsManager.current = new WebSocketManager('ws://localhost:8000/ws');
        
        wsManager.current.onConnect(() => setIsConnected(true));
        wsManager.current.onDisconnect(() => setIsConnected(false));
        
        wsManager.current.onMessage((message) => {
            setMessages(prev => [...prev, message]);
        });

        return () => wsManager.current.disconnect();
    }, []);

    return (
        <div className="app-container">
            <VideoInterface 
                wsManager={wsManager.current}
                isConnected={isConnected}
            />
            <ChatInterface 
                messages={messages}
                wsManager={wsManager.current}
                isConnected={isConnected}
            />
        </div>
    );
}

export default App;