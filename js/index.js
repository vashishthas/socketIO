const express= require("express");
var http = require("http");
const app = express();
const port = process.env.PORT || 5000;
var server = http.createServer(app);
var io = require("socket.io")(server);

//middlewre
app.use(express.json());
var clients = {};

io.on("connection", (socket) => {
  console.log("connetetd");
  console.log(socket.id, "has joined");
  socket.on("/test",(msg)=>{
    console.log(msg);
  });
//   socket.on("signin", (id) => {
//     console.log(id);
//     clients[id] = socket;
//     console.log(clients);
//   });
  socket.on("message", (msg) => {
    // reply=msg[radius];
    console.log(msg);
    clients[1]=socket;
    // console.log(clients)
    // let targetId = msg[targetId];
    // if (clients[1]) 
    // clients[1].emit("reply", "010"+JSON.stringify(msg));
    socket.emit("reply", "010"+JSON.stringify(msg));
    console.log("reply done")
  });
});

server.listen(port, "0.0.0.0", () => {
  console.log("server started");
});