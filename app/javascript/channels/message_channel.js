import consumer from "./consumer"

if(location.pathname.match(/\/rooms\/\d/)){

  consumer.subscriptions.create({
    channel: "MessageChannel",
    room_id: location.pathname.match(/\d+/)[0]
  }, {
    connected() {
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      const user = data.user;
      const message = data.message;
      
      const messagesArea = document.getElementById("messages-area");
      
      const messageContainer = document.createElement("div");
      messageContainer.classList.add("message");
      
      const messageUser = document.createElement("div");
      messageUser.classList.add("message-user");
      
      if (user.image) {
        const userImage = document.createElement("img");
        userImage.src = user.image;
        userImage.classList.add("chat-user-img");
        messageUser.appendChild(userImage);
      }
      
      const userLink = document.createElement("a");
      userLink.href = "/users/" + user.id;
      userLink.textContent = user.nickname;
      messageUser.appendChild(userLink);
      
      messageContainer.appendChild(messageUser);
      
      const messageContent = document.createElement("div");
      messageContent.classList.add("message-content");
      messageContent.textContent = message.content;
      
      messageContainer.appendChild(messageContent);
      
      messagesArea.appendChild(messageContainer);
      
      const chatInput = document.getElementById("chat-input");
      chatInput.reset();
      
      const submitButton = chatInput.querySelector('input[type="submit"]');
      submitButton.disabled = false;
    }
  })
}