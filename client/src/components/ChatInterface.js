import React, { useState, useRef, useEffect } from 'react';

const ChatInterface = ({ messages, wsManager, isConnected }) => {
    const [inputText, setInputText] = useState('');
    const messagesEndRef = useRef(null);

    const scrollToBottom = () => {
        messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
    };

    useEffect(() => {
        scrollToBottom();
    }, [messages]);

    const handleSubmit = (e) => {
        e.preventDefault();
        if (!inputText.trim() || !wsManager || !isConnected) return;

        wsManager.sendMessage({
            type: 'text',
            content: inputText
        });

        setInputText('');
    };

    return (
        <div className="chat-interface">
            <div className="messages-container">
                {messages.map((msg, index) => (
                    <div
                        key={index}
                        className={`message ${msg.type === 'user' ? 'user-message' : 'ai-message'}`}
                    >
                        {msg.content}
                    </div>
                ))}
                <div ref={messagesEndRef} />
            </div>
            <form onSubmit={handleSubmit} className="input-container">
                <input
                    type="text"
                    value={inputText}
                    onChange={(e) => setInputText(e.target.value)}
                    placeholder="Type a message..."
                    disabled={!isConnected}
                />
                <button type="submit" disabled={!isConnected}>
                    Send
                </button>
            </form>
        </div>
    );
};

export default ChatInterface;