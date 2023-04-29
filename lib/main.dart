import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_tut/provider/room_data_provider.dart';
import 'package:tictactoe_tut/screens/create_room.dart';
import 'package:tictactoe_tut/screens/game_screen.dart';
import 'package:tictactoe_tut/screens/join_room.dart';
import 'package:tictactoe_tut/screens/main_menu.dart';
import 'package:tictactoe_tut/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: bgColor),
        // home: const MainMenuScreen(),
        routes: {
          MainMenuScreen.routeName: (context) => const MainMenuScreen(),
          CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
          JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
          GameScreen.routeName: (context) => const GameScreen(),
        },
        initialRoute: MainMenuScreen.routeName,
      ),
    );
  }
}
