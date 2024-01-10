import 'package:flutter/material.dart';
import 'package:hh_express/features/chat/models/message.dart';
import 'package:hh_express/features/chat/screens/chat/widgets/msgs_list.dart';

class ChatWithBackground extends StatelessWidget {
  const ChatWithBackground({
    Key? key,
    required this.msgs,
  }) : super(key: key);

  final Set<Message> msgs;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Color.fromARGB(255, 208, 226, 180),
      child: MsgsList(
        msgs: msgs,
      ),
    );
  }
}
