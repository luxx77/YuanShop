import 'package:hh_express/features/chat/models/message.dart';
import 'package:image_picker/image_picker.dart';

abstract class ChatEvent {}

class SendMessageEvent extends ChatEvent {
  SendMessageEvent({
    this.message,
    this.file,
  }) : super();

  final String? message;
  final XFile? file;
}

class GetMessagesListEvent extends ChatEvent {
  GetMessagesListEvent(this.page, this.gettinNewPage) : super();
  final int page;
  final bool gettinNewPage;
}

class AddMessageToListEvent extends ChatEvent {
  AddMessageToListEvent({
    required this.message,
  }) : super();
  final Message message;
}
