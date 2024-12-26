import React, { useEffect, useRef } from 'react';

const VideoInterface = ({ wsManager, isConnected }) => {
    const userVideoRef = useRef(null);
    const aiVideoRef = useRef(null);
    const mediaStreamRef = useRef(null);

    useEffect(() => {
        if (!wsManager || !isConnected) return;

        async function setupMediaStream() {
            try {
                const stream = await navigator.mediaDevices.getUserMedia({
                    video: true,
                    audio: true
                });

                mediaStreamRef.current = stream;
                if (userVideoRef.current) {
                    userVideoRef.current.srcObject = stream;
                }

                // Setup audio processing
                const audioContext = new AudioContext();
                const source = audioContext.createMediaStreamSource(stream);
                const processor = audioContext.createScriptProcessor(4096, 1, 1);

                processor.onaudioprocess = (e) => {
                    const audioData = e.inputBuffer.getChannelData(0);
                    wsManager.sendAudio(audioData);
                };

                source.connect(processor);
                processor.connect(audioContext.destination);

            } catch (error) {
                console.error('Error accessing media devices:', error);
            }
        }

        setupMediaStream();

        return () => {
            if (mediaStreamRef.current) {
                mediaStreamRef.current.getTracks().forEach(track => track.stop());
            }
        };
    }, [wsManager, isConnected]);

    useEffect(() => {
        if (!wsManager || !isConnected) return;

        wsManager.onVideoFrame((frameData) => {
            if (aiVideoRef.current) {
                // Convert frame data to blob and create URL
                const blob = new Blob([frameData], { type: 'image/jpeg' });
                const url = URL.createObjectURL(blob);
                aiVideoRef.current.src = url;
                URL.revokeObjectURL(url);
            }
        });
    }, [wsManager, isConnected]);

    return (
        <div className="video-interface">
            <div className="video-container">
                <video
                    ref={userVideoRef}
                    autoPlay
                    playsInline
                    muted
                    className="user-video"
                />
                <img
                    ref={aiVideoRef}
                    className="ai-video"
                    alt="AI Avatar"
                />
            </div>
        </div>
    );
};

export default VideoInterface;