import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_tut/provider/room_data_provider.dart';
import 'package:tictactoe_tut/resources/socket_methods.dart';
import 'package:tictactoe_tut/views/game_board.dart';
import 'package:tictactoe_tut/views/score_board.dart';
import 'package:tictactoe_tut/views/waiting_lobby.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/game';

  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayersStateListener(context);
    _socketMethods.pointIncreaseListener(context);
    _socketMethods.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider dataProvider = Provider.of<RoomDataProvider>(context);
    return Scaffold(
      body: dataProvider.roomData['isJoined']
          ? const WaitingLobby()
          : SafeArea(
              child: Column(
                children: [
                  const ScoreBoard(),
                  const GameBoard(),
                  Text('${dataProvider.roomData['turn']['nickname']}\'s turn')
                ],
              ),
            ),
    );
  }
}
