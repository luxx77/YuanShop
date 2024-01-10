import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hh_express/app/setup.dart';
import 'package:hh_express/data/local/secured_storage.dart';
import 'package:hh_express/features/chat/bloc/chat_events.dart';
import 'package:hh_express/features/chat/bloc/chat_state.dart';
import 'package:hh_express/features/chat/models/message.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/overlay_helper.dart';
import 'package:hh_express/helpers/routes.dart';
import 'package:hh_express/repositories/chat/chat_repository.dart';
import 'package:hh_express/settings/enums.dart';
import 'package:hh_express/settings/consts.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatState()) {
    final repo = getIt<ChatRepo>();

    ///Adding user's sended message (file or text) to messages list, don't request messages list from the server for that.
    on<AddMessageToListEvent>((event, emit) async {
      await Future.delayed(
        Duration(
          seconds: 1,
        ),
      );
      var newSet = state.messages;
      newSet = {
        ...{event.message},
        ...newSet ?? {}
      };
      final newList = newSet.toList();
      newSet = newList.toSet();
      emit(
        state.update(
          messages: newSet,
        ),
      );
      return;
    });

    ///Getting messages page, if page is first - connect to websocket.
    on<GetMessagesListEvent>((event, emit) async {
      if (LocalStorage.getToken == null) {
        return emit(
          ChatState(
            messagesListState: APIState.error,
            errorMessage: appRouter.currentContext.l10n.unauthorized,
          ),
        );
      }
      emit(
        state.update(
          messagesListState: APIState.loading,
          gettingNewPage: event.gettinNewPage,
        ),
      );

      final data = await repo.getMessagesList(event.page);
      if (data.success) {
        final chatState = ChatState.fromMap(data.data);
        if (!event.gettinNewPage) {
          connectToWebsocket(chatState.conversation?.id ?? 0);
        }
        if (event.page == 1) {
          state.messages?.clear();
        }
        emit(
          state.update(
            messagesListState: APIState.success,
            messages: state.messages == null
                ? Set.from(chatState.messages ?? {})
                : Set.from(state.messages ?? {})
              ..addAll(
                chatState.messages!,
              ),
            conversation: chatState.conversation,
            currentPage: chatState.currentPage,
            notification_count: chatState.notification_count,
            lastPage: chatState.lastPage,
          ),
        );
        return;
      }
      emit(
        state.update(
          messagesListState: APIState.error,
          errorMessage: data.error,
        ),
      );
    });

    ///Sending message to server (file or text)
    on<SendMessageEvent>(
      (event, emit) async {
        final response = await repo.sendMessage(
          type: event.file != null ? 'file' : 'text',
          file: event.file,
          message: event.message,
        );
        final message = Message.fromMap(response.data['message']);
        add(
          AddMessageToListEvent(
            message: Message(
              image: event.file,
              date: message.date,
              id: message.id,
              is_owner: message.is_owner,
              body: message.body,
              type: message.type,
              hour: message.hour,
            ),
          ),
        );
      },
    );
  }

  final _authEndpoint = '${EndPoints.baseUrl}api/broadcasting/auth';
  PusherChannelsClient? pusher;

  void connectToWebsocket(int conversationId) async {
    late PusherChannelsOptions options;

    options = const PusherChannelsOptions.fromHost(
      host: EndPoints.host,
      port: 6001,
      scheme: 'ws',
      key: 'asmanKbdgI',
      metadata: PusherChannelsOptionsMetadata(
        client: 'js',
        protocol: 7,
        version: '4.3.1',
      ),
    );
    pusher = PusherChannelsClient.websocket(
      options: options,
      connectionErrorHandler: (dynamic exception, trace, refresh) {
        //TODO: show snack bar until succesful connection, don't remove refresh()
        refresh();
      },
    );

    PusherChannelsPackageLogger.enableLogs();
    final token = LocalStorage.getToken;

    await pusher?.connect();
    final channel = pusher?.privateChannel('User.Chat.$conversationId',
        authorizationDelegate:
            EndpointAuthorizableChannelTokenAuthorizationDelegate
                .forPrivateChannel(
          authorizationEndpoint: Uri.parse(_authEndpoint),
          headers: {'Authorization': 'Bearer $token'},
          onAuthFailed: (exception, trace) {
            //TODO: show dialog with error.
            SnackBarHelper.showTopSnack(
                appRouter.currentContext.l10n.socketExeption, APIState.init);
          },
        ));
    channel?.bind('MessageCreated').listen((event) {
      final message = Message.fromJson(event.data);
      add(AddMessageToListEvent(message: message));
    });
    channel?.subscribe();
  }
}
