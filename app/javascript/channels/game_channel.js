import consumer from "./consumer"

consumer.subscriptions.create("GameChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log("game", data)
    const div_locale = document.getElementById(`game_${data.content}`);
    console.log(data.content);
    console.log(div_locale);  
    if (div_locale)
    { 
      location.reload();
    }
  }
});
