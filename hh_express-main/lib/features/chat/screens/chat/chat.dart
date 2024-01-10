import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hh_express/features/chat/bloc/chat_bloc.dart';
import 'package:hh_express/features/chat/bloc/chat_events.dart';
import 'package:hh_express/features/chat/screens/chat/widgets/chat_title.dart';
import 'package:hh_express/features/chat/screens/chat/widgets/chat_with_bg.dart';
import 'package:hh_express/features/chat/screens/chat/widgets/type_and_send.dart';
import 'package:hh_express/features/chat/screens/common/back.dart';
import 'package:hh_express/settings/enums.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatBloc chatBloc;

  @override
  void dispose() {
    if (mounted) {
      chatBloc.pusher?.disconnect();
    }
    super.dispose();
  }

  @override
  void initState() {
    chatBloc = BlocProvider.of<ChatBloc>(context);
    chatBloc.add(GetMessagesListEvent(1, false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final chatBLoc = BlocProvider.of<ChatBloc>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        leading: const BackBtn(),
        title: ChatTitle(
          title: chatBLoc.state.conversation?.name ?? '',
          id: chatBLoc.state.conversation?.id ?? 0,
        ),
      ),
      body: chatBLoc.state.messagesListState == APIState.loading &&
              (!chatBLoc.state.gettingNewPage!)
          ? Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : chatBLoc.state.messagesListState == APIState.error
              ? _centerText(chatBLoc.state.errorMessage!)
              : ChatWithBackground(
                  msgs: chatBLoc.state.messages ?? {},
                ),
      bottomNavigationBar: chatBLoc.state.messagesListState == APIState.error
          ? null
          : const TypeAndSend(),
    );
  }

  // List<Widget> get chatActions {
  //   return [
  //     IconButton(
  //       onPressed: () {},
  //       icon: const Icon(Icons.call),
  //     ),
  //     IconButton(
  //       onPressed: () {},
  //       icon: const Icon(Icons.more_vert),
  //     ),
  //   ];
  // }
}

Widget _centerText(String text) {
  return Center(
    child: Text(
      text,
    ),
  );
}
