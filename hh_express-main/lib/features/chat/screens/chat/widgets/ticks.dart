import 'package:flutter/material.dart';
import 'package:hh_express/features/chat/models/message.dart';
import 'package:hh_express/settings/consts.dart';

class Ticks extends StatelessWidget {
  const Ticks({
    Key? key,
    required this.msg,
  }) : super(key: key);

  final Message msg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Center(
        child: msg.is_seen
            ? const Icon(
                Icons.done_all,
                color: AppColors.white,
                size: 18,
              )
            : const Icon(
                Icons.done,
                color: AppColors.white,
                size: 18,
              ),
      ),
    );
  }
}
