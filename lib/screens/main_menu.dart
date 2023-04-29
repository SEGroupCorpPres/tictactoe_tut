import 'package:flutter/material.dart';
import 'package:tictactoe_tut/responsive/responsive.dart';
import 'package:tictactoe_tut/screens/create_room.dart';
import 'package:tictactoe_tut/screens/join_room.dart';
import 'package:tictactoe_tut/widgets/custom_button.dart';

class MainMenuScreen extends StatelessWidget {
  static String routeName = '/main-menu';

  const MainMenuScreen({super.key});

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void joinRoomScreen(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(onPressed: () => createRoom(context), text: 'Create Room'),
            const SizedBox(height: 20),
            CustomButton(onPressed: () => joinRoomScreen(context), text: 'Join Room'),
          ],
        ),
      ),
    );
  }
}
