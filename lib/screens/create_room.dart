import 'package:flutter/material.dart';
import 'package:tictactoe_tut/responsive/responsive.dart';
import 'package:tictactoe_tut/resources/socket_methods.dart';
import 'package:tictactoe_tut/widgets/custom_button.dart';
import 'package:tictactoe_tut/widgets/custom_text.dart';
import 'package:tictactoe_tut/widgets/custom_textfield.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = '/create-room';

  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _controller = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _socketMethods.createRoomSuccessListener(context);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
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
                text: 'Create Room',
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
              CustomButton(onPressed: () => _socketMethods.createRoom(_controller.text), text: 'Create'),
            ],
          ),
        ),
      ),
    );
  }
}
