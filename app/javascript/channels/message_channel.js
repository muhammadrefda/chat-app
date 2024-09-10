import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {
  const chatroomElement = document.getElementById('messages')
  const chatroomId = chatroomElement.dataset.chatroomId

  consumer.subscriptions.create({ channel: "MessageChannel", chatroom_id: chatroomId }, {
    connected() {
      //Called when the subscription is ready for use on the server
      console.log("Connected to the chatroom");

    },

    disconnected() {
      // Called when the subscription has been terminated by the server
      console.log("Disconnected from the chatroom");

    },

    received(data) {
      // Called when there's incoming data on the websocket for this channel
      chatroomElement.insertAdjacentHTML('beforeend', data)
    }
  })
})
