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
      const userImageDiv = document.getElementById('user-image');
      const imageTag = userImageDiv.innerHTML;
      const imageURL = imageTag.match(/src="([^"]+)"/)[1];
      userImageDiv.dataset.image = imageURL;
      
      const messagesArea = document.getElementById("messages-area");
      
      const messageContainer = document.createElement("div");
      messageContainer.classList.add("message");
      
      const messageUser = document.createElement("div");
      messageUser.classList.add("message-user");
      
      if (imageURL != "") {
        const userImage = document.createElement("img");
        userImage.src = imageURL;
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