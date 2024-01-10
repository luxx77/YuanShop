import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hh_express/features/chat/models/message.dart';

class MessageText extends StatelessWidget {
  const MessageText({
    Key? key,
    required this.msg,
  }) : super(key: key);

  final Message msg;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 250,
      ),
      child: msg.image != null
          ? Image.file(
              File(
                msg.image!.path,
              ),
            )
          : msg.type == 'file'
              ? Image.network(
                  msg.body,
                  scale: 10,
                )
              : Text(
                  msg.body,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                ),
    );
  }
}
