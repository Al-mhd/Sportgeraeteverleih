var url = "ws://localhost:8080/Sportgeraeteverleih_war/chat"
// var url = "ws://" + document.location.host + document.location.pathname + "chat"
// ws://localhost:8080/Sportgeraeteverleih_war/ws/ws.jspchat
console.log("url = " + url)
var ws = new WebSocket(url);
ws.onmessage = (ev) => {
    onMessage(ev);
}
ws.onopen = () => {
    onOpen();
}

function onOpen() {
    console.log("connection opened: url = " + url)
}

function onClose() {
    console.log("connection closed: url = " + url)
}

function onMessage(event) {
    console.log(event)
}

function send() {

}


