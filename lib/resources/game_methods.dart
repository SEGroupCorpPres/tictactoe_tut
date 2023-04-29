import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tictactoe_tut/provider/room_data_provider.dart';
import 'package:tictactoe_tut/utils/utils.dart';

class GameMethods {
  void checkWinner(BuildContext context, Socket socketClient) {
    RoomDataProvider dataProvider = Provider.of<RoomDataProvider>(context, listen: false);
    String winner = '';
    // Checking rows
    if (dataProvider.displayElements[0] == dataProvider.displayElements[1] && dataProvider.displayElements[0] == dataProvider.displayElements[2] && dataProvider.displayElements[0] != '') {
      winner = dataProvider.displayElements[0];
    }
    if (dataProvider.displayElements[3] == dataProvider.displayElements[4] && dataProvider.displayElements[3] == dataProvider.displayElements[5] && dataProvider.displayElements[3] != '') {
      winner = dataProvider.displayElements[3];
    }
    if (dataProvider.displayElements[6] == dataProvider.displayElements[7] && dataProvider.displayElements[6] == dataProvider.displayElements[8] && dataProvider.displayElements[6] != '') {
      winner = dataProvider.displayElements[6];
    }

    // Checking Column
    if (dataProvider.displayElements[0] == dataProvider.displayElements[3] && dataProvider.displayElements[0] == dataProvider.displayElements[6] && dataProvider.displayElements[0] != '') {
      winner = dataProvider.displayElements[0];
    }
    if (dataProvider.displayElements[1] == dataProvider.displayElements[4] && dataProvider.displayElements[1] == dataProvider.displayElements[7] && dataProvider.displayElements[1] != '') {
      winner = dataProvider.displayElements[1];
    }
    if (dataProvider.displayElements[2] == dataProvider.displayElements[5] && dataProvider.displayElements[2] == dataProvider.displayElements[8] && dataProvider.displayElements[2] != '') {
      winner = dataProvider.displayElements[2];
    }

    // Checking Diagonal
    if (dataProvider.displayElements[0] == dataProvider.displayElements[4] && dataProvider.displayElements[0] == dataProvider.displayElements[8] && dataProvider.displayElements[0] != '') {
      winner = dataProvider.displayElements[0];
    }
    if (dataProvider.displayElements[2] == dataProvider.displayElements[4] && dataProvider.displayElements[2] == dataProvider.displayElements[6] && dataProvider.displayElements[2] != '') {
      winner = dataProvider.displayElements[2];
    } else if (dataProvider.filledBoxes == 9) {
      winner = '';
      showGameDialog(context, 'Draw');
    }

    if (winner != '') {
      if (dataProvider.player1.playerType == winner) {
        showGameDialog(context, '${dataProvider.player1.nickname} won!');
        socketClient.emit('winner', {
          'winnerSocketId': dataProvider.player1.socketID,
          'roomId': dataProvider.roomData['_id'],
        });
      } else {
        showGameDialog(context, '${dataProvider.player2.nickname} won!');
        socketClient.emit('winner', {
          'winnerSocketId': dataProvider.player2.socketID,
          'roomId': dataProvider.roomData['_id'],
        });
      }
    }
  }

  void clearBoard(BuildContext context) {
    RoomDataProvider dataProvider = Provider.of<RoomDataProvider>(context, listen: false);

    for (int i = 0; i < dataProvider.displayElements.length; i++) {
      dataProvider.updateDisplayElements(i, '');
    }
    dataProvider.setFilledBoxesTo0();
  }
}
