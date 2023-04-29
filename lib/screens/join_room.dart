import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tictactoe_tut/responsive/responsive.dart';
import 'package:tictactoe_tut/resources/socket_methods.dart';
import 'package:tictactoe_tut/widgets/custom_button.dart';
import 'package:tictactoe_tut/widgets/custom_text.dart';
import 'package:tictactoe_tut/widgets/custom_textfield.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join-room';

  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.errorOccurredListener(context);
    _socketMethods.updatePlayersStateListener(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    _idController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomText(
                text: 'Join Room',
                shadows: [
                  Shadow(
                    blurRadius: 40,
                    color: Colors.blue,
                  ),
                ],
                fontSize: 70,
              ),
              SizedBox(height: size.height * 0.08),
              CustomTextField(textEditingController: _controller, hintText: 'Enter your nick name'),
              SizedBox(height: size.height * 0.04),
              CustomTextField(textEditingController: _idController, hintText: 'Enter Game ID'),
              SizedBox(height: size.height * 0.04),
              CustomButton(onPressed: () => _socketMethods.joinRoom(_controller.text, _idController.text), text: 'Join'),
            ],
          ),
        ),
      ),
    );
  }
}
