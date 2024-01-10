import 'dart:convert';

import 'package:hh_express/features/chat/models/conversation.dart';
import 'package:hh_express/features/chat/models/message.dart';
import 'package:hh_express/settings/enums.dart';

class ChatState {
  final int? currentPage;
  final Set<Message>? messages;
  final Conversation? conversation;
  final int? lastPage;
  final int? notification_count;
  final APIState? messagesListState;
  final bool? gettingNewPage;
  final String? errorMessage;

  ChatState({
    this.conversation,
    this.lastPage,
    this.messages,
    this.notification_count,
    this.currentPage,
    this.messagesListState = APIState.init,
    this.errorMessage,
    this.gettingNewPage = false,
  });

  ChatState update({
    int? currentPage,
    Set<Message>? messages,
    Conversation? conversation,
    int? lastPage,
    int? notification_count,
    APIState? messagesListState,
    String? errorMessage,
    bool? gettingNewPage,
  }) {
    return ChatState(
        currentPage: currentPage ?? this.currentPage,
        messages: messages ?? this.messages,
        conversation: conversation ?? this.conversation,
        lastPage: lastPage ?? this.lastPage,
        notification_count: notification_count ?? this.notification_count,
        messagesListState: messagesListState ?? this.messagesListState,
        errorMessage: errorMessage ?? this.errorMessage,
        gettingNewPage: gettingNewPage ?? false);
  }

  factory ChatState.fromMap(Map<String, dynamic> map) {
    return ChatState(
      notification_count:
          map['notification_count'] != null ? map['notification_count'] : 0,
      currentPage: map['messages']['pagination']['current_page'] != null
          ? map['messages']['pagination']['current_page'] as int
          : 1,
      messages: Set<Message>.from(
        (map['messages']['data'] as List<dynamic>).map<Message>(
          (x) => Message.fromMap(x as Map<String, dynamic>),
        ),
      ),
      conversation:
          Conversation.fromMap(map['conversation'] as Map<String, dynamic>),
      lastPage: map['messages']['pagination']['last_page'] as int,
    );
  }

  factory ChatState.fromJson(String source) =>
      ChatState.fromMap(json.decode(source) as Map<String, dynamic>);
}


// 'conversation'
// 'messages'
// 'notification_count'

// messages => {
//                 'data' => [
//                      {
//                             'id'              => $this->id,
//                             'body'            => $this->body,
//                             'type'            => $this->type,
//                             'date'            => $this->created_at->format('Y-m-d'),
//                             'hour'            => $this->created_at->format('H:i'),
//                             'created_at'  => $this->created_at->format('Y-m-d H:i'),
//                             'is_owner'        => true,
//                             'is_seen'         => false
//                      },
//                 ],
//                 'pagination' => {
//                     "current_page"  => $this->currentPage(),
//                     "last_page"     => $this->lastPage(),
//                     "prev_page_url" => $this->previousPageUrl(),
//                     "next_page_url" => $this->nextPageUrl(),
//                     "per_page"      => $this->perPage(),
//                     "total"         => $this->total(),
//                     "count"         => $this->count()
//                 }
// }
