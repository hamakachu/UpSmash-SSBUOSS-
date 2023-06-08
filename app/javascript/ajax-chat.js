// function generateMessageHTML(nickname, content) {
//   return `
//     <div class="message">
//       <div class="message-user">
//         ${nickname}
//       </div>
//       <div class="message-content">
//         ${content}
//       </div>
//     </div>`;
// }

// function post() {
//   const chatSubmit = document.getElementById("chat-submit");
//   chatSubmit.addEventListener("click", (e) => {
//     e.preventDefault();
//     const chatInput = document.getElementById("chat-input");
//     const roomId = document.getElementById("room-id").dataset.roomId;
//     const formData = new FormData(chatInput);
//     const XHR = new XMLHttpRequest();
//     XHR.open("POST", `/rooms/${roomId}/messages`, true);
//     XHR.responseType = "json";
//     XHR.send(formData);
//     XHR.onload = () => {
//       if (XHR.status != 200) {
//         alert(`Error ${XHR.status}: ${XHR.statusText}`);
//         return null;
//       };
//       const messagesArea = document.getElementById("messages-area");
//       const formText = document.getElementById("content");
//       const nickname = document.getElementById("user-nickname").dataset.nickname;
//       const gotMessage = XHR.response.message;
//       const html = generateMessageHTML(nickname, gotMessage.content);
//       messagesArea.insertAdjacentHTML("beforeend", html);
//       formText.value = "";
//     };
//   });
// }

// window.addEventListener('load', post);