const express = require("express");
const http = require("http");
const mongoose = require("mongoose");

const app = express();

const port = process.env.PORT || 3000;
var server = http.createServer(app);
const Room = require("./models/room");

var io = require("socket.io")(server);
app.use(express.json());

const DB = "your mongoose database";

io.on("connection", (socket) => {
  console.log("connection success");
  socket.on("createRoom", async ({ nickname }) => {
    console.log(nickname);
    try {
      let room = new Room();
      let player = {
        socketID: socket.id,
        nickname,
        playerType: "X",
      };
      room.players.push(player);
      room.turn = player;
      room = await room.save();
      console.log(room);
      const roomID = room._id.toString();
      socket.join(roomID);
      io.to(roomID).emit("createRoomSuccess", room);
    } catch (e) {
      console.log(e);
    }
  });

  socket.on("joinRoom", async ({ nickname, roomID }) => {
    try {
      if (!roomID.match(/^[0-9a-fA-F]{24}$/)) {
        socket.emit("errorOccurred", "Please enter a valid room ID");
        return;
      }
      let room = await Room.findById(roomID);
      if (room.isJoined) {
        let player = {
          nickname,
          socketID: socket.id,
          playerType: "O",
        };
        socket.join(roomID);
        room.isJoined = false;
        room.players.push(player);
        room = await room.save();
        io.to(roomID).emit("joinRoomSuccess", room);
        io.to(roomID).emit("updatePlayers", room.players);
        io.to(roomID).emit("updateRoom", room);
      } else {
        socket.emit("errorOccurred", "The game in progress, try again later");
      }
    } catch (e) {
      console.log(e);
    }
  });
  socket.on("tap", async ({ index, roomID }) => {
    try {
      let room = await Room.findById(roomID);

      let choice = room.turn.playerType;
      if (room.turnIndex == 0) {
        room.turn = room.players[1];
        room.turnIndex = 1;
      } else {
        room.turn = room.players[0];
        room.turnIndex = 0;
      }
      room = await room.save();
      io.to(roomID).emit("tapped", {
        index,
        choice,
        room,
      });
    } catch (e) {
      console.log(e);
    }
  });

  socket.on("winner", async ({ winnerSocketId, roomID }) => {
    try {
      let room = await Room.findById(roomId);
      let player = room.players.find(
        (playerr) => playerr.socketID == winnerSocketId
      );
      player.points += 1;
      room = await room.save();

      if (player.points >= room.maxRounds) {
        io.to(roomId).emit("endGame", player);
      } else {
        io.to(roomId).emit("pointIncrease", player);
      }
    } catch (e) {
      console.log(e);
    }
  });
});
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection successful");
  })
  .catch((e) => {
    console.log(e);
  });

server.listen(port, "0.0.0.0", () => {
  console.log(`Server started on port and running on port ${port}`);
});
