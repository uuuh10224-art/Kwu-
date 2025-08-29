html>
<html lang="ar">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>شات جوال</title>
<style>
  body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #121212;
    color: #fff;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
  }
  .chat-container {
    width: 100%;
    max-width: 400px;
    height: 100vh;
    display: flex;
    flex-direction: column;
    background: #1e1e1e;
  }
  .header {
    padding: 15px;
    background: #2a2a2a;
    text-align: center;
    font-weight: bold;
    font-size: 18px;
  }
  .messages {
    flex: 1;
    padding: 10px;
    overflow-y: auto;
    display: flex;
    flex-direction: column;
  }
  .message {
    margin-bottom: 10px;
    padding: 10px 15px;
    border-radius: 20px;
    max-width: 80%;
    word-wrap: break-word;
  }
  .user-message {
    background: #4caf50;
    color: #fff;
    align-self: flex-end;
  }
  .bot-message {
    background: #2a2a2a;
    color: #fff;
    align-self: flex-start;
  }
  .input-container {
    display: flex;
    border-top: 1px solid #333;
    padding: 10px;
    background: #1e1e1e;
  }
  .input-container input {
    flex: 1;
    padding: 10px;
    border-radius: 20px;
    border: none;
    outline: none;
    font-size: 14px;
    background: #2a2a2a;
    color: #fff;
  }
  .input-container button {
    margin-left: 10px;
    padding: 10px 15px;
    border-radius: 20px;
    border: none;
    background: #4caf50;
    color: #fff;
    cursor: pointer;
  }
</style>
</head>
<body>

<div class="chat-container">
  <div class="header">شات جوال</div>
  <div class="messages" id="messages"></div>
  <div class="input-container">
    <input type="text" id="userInput" placeholder="اكتب رسالتك...">
    <button onclick="sendMessage()">إرسال</button>
  </div>
</div>

<script>
  const messagesDiv = document.getElementById('messages');

  function sendMessage() {
    const input = document.getElementById('userInput');
    const text = input.value.trim();
    if (!text) return;

    const userMsg = document.createElement('div');
    userMsg.classList.add('message', 'user-message');
    userMsg.textContent = text;
    messagesDiv.appendChild(userMsg);
    input.value = '';
    messagesDiv.scrollTop = messagesDiv.scrollHeight;

    // رد تلقائي
    setTimeout(() => {
      const botMsg = document.createElement('div');
      botMsg.classList.add('message', 'bot-message');
      botMsg.textContent = "تم استلام رسالتك: " + text;
      messagesDiv.appendChild(botMsg);
      messagesDiv.scrollTop = messagesDiv.scrollHeight;
    }, 500);
  }

  // إرسال بالضغط على Enter
  document.getElementById('userInput').addEventListener('keydown', function(e) {
    if (e.key === 'Enter') sendMessage();
  });
</script>

</body>
</html>
