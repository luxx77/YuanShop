import 'package:flutter/material.dart';

class ChatTitle extends StatelessWidget {
  const ChatTitle({
    Key? key,
    required this.title,
    required this.id,
  }) : super(key: key);

  final String title;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ],
    );
  }
}
