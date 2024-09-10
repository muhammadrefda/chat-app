import React, { useState, useEffect } from "react";

const Chatroom = ({ chatroomId }) => {
    const [messages, setMessages] = useState([]);
    const [content, setContent] = useState("");

    useEffect(() => {
        const subscription = new WebSocket(`ws://localhost:3000/cable?chatroom_id=${chatroomId}`);

        subscription.onmessage = (event) => {
            const data = JSON.parse(event.data);
            if (data.type === "ping") return;
            setMessages((prevMessages) => [...prevMessages, data.message]);
        };

        return () => subscription.close();
    }, [chatroomId]);

    const handleSubmit = (e) => {
        e.preventDefault();
        fetch("/messages", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({ message: { content, chatroom_id: chatroomId } }),
        }).then(() => setContent(""));
    };

    return (
        <div>
            <h1>Chatroom</h1>
            <div id="messages">
                {messages.map((message, index) => (
                    <p key={index}>
                        <strong>{message.created_at}</strong>: {message.content}
                    </p>
                ))}
            </div>
            <form onSubmit={handleSubmit}>
                <input
                    type="text"
                    value={content}
                    onChange={(e) => setContent(e.target.value)}
                    placeholder="Type your message..."
                />
                <button type="submit">Send</button>
            </form>
        </div>
    );
};

export default Chatroom;
