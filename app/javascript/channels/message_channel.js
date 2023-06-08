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
      const image = document.getElementById("user-image").dataset.image
      const html = `
          <div class="message">
            <div class="message-user">
              <img src="${image}" class="chat-user-img" >
              <a href="/users/${data.user.id}">${data.user.nickname}</a>
            </div>
            <div class="message-content">
              ${data.message.content}
            </div>
          </div>`;
      const messagesArea = document.getElementById("messages-area")
      messagesArea.insertAdjacentHTML("beforeend", html);
      const chatInput = document.getElementById("chat-input")
      chatInput.reset();
      const submitButton = chatInput.querySelector('input[type="submit"]');
      submitButton.disabled = false;
    }
  })
}