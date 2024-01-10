import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/chat/bloc/chat_bloc.dart';
import 'package:hh_express/features/chat/bloc/chat_events.dart';
import 'package:hh_express/features/chat/models/message.dart';
import 'package:hh_express/features/chat/screens/chat/widgets/msg_wrapper.dart';

class MsgsList extends StatefulWidget {
  const MsgsList({
    Key? key,
    required this.msgs,
  }) : super(key: key);

  final Set<Message> msgs;

  @override
  State<MsgsList> createState() => _MsgsListState();
}

class _MsgsListState extends State<MsgsList> {
  late ScrollController listController;
  late ChatBloc chatBloc;

  @override
  void initState() {
    chatBloc = BlocProvider.of(context);
    listController = ScrollController();
    listController.addListener(() {
      if (listController.position.maxScrollExtent == listController.offset &&
          chatBloc.state.currentPage != null) {
        chatBloc
            .add(GetMessagesListEvent(chatBloc.state.currentPage! + 1, true));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      padding: EdgeInsets.only(bottom: 50.h),
      controller: listController,
      physics: BouncingScrollPhysics(),
      itemCount: widget.msgs.length,
      itemBuilder: (context, ix) {
        final msg = widget.msgs.elementAt(ix);
        return Column(
          children: [
            Row(
              mainAxisAlignment: msg.is_owner
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                MessageWrapper(msg: msg),
              ],
            ),
          ],
        );
      },
    );
  }
}
