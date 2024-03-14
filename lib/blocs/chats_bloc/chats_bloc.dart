import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:instax/blocs/chats_bloc/chats_state.dart';

part 'chats_event.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final ChatRepository _chatRepository = FirebaseChatRepository();

  ChatsBloc() : super(ChatsState()) {
    on<ChatsGetRequested>((event, emit) async {
      print('event.uid${event.uid}');
      try {
        final chatList = await _chatRepository.getChatLists(
          event.uid ?? "",
        );
        emit(state.copyWith(
          chatList: chatList.map((chat) => chat).toList(),
          status: ChatsListStatus.success,
        ));
      } catch (e) {
        print('error : ${e.toString()}');
        emit(state.copyWith(status: ChatsListStatus.failure));
      }
    });

    on<ChatsSelected>((event, emit) {
      emit(state
          .copyWith(chatRoomSelected: null, chatMessage: [], imageList: []));
      try {
        emit(state.copyWith(
            chatRoomSelected: event.chatRoomSelected,
            status: ChatsListStatus.initial));
      } catch (e) {
        print('error : ${e.toString()}');
      }
    });

    on<GetChatsMessage>((event, emit) async {
      emit(state.copyWith(
        chatMessage: [],
        imageList: [],
      ));
      try {
        // message length
        final messageLength = state.chatMessage.length;

        log('state.chatMessage.length ${messageLength}');

        final chatMessages = await _chatRepository.getChatMessages(
          chatId: state.chatRoomSelected!.id,
          numberOfMessages: messageLength,
        );

        log('chatMessages ${chatMessages.length}');

        // filter messages that are not in state.chatMessage
        chatMessages.removeWhere((message) => state.chatMessage
            .any((element) => element.timestamp == message.timestamp));

        log('chatMessages removeWhere ${chatMessages.length}');

        // Extract image URLs from chat messages
        final List<String> imageUrls = chatMessages
            .where((message) => message.imageUrl != null)
            .map((message) => message.imageUrl!)
            .toList();

        // remove blank image urls
        imageUrls.removeWhere((element) => element == "");

        emit(state.copyWith(
          chatMessage: [...chatMessages, ...state.chatMessage],
          // imageList: [...state.imageList, ...imageUrls],
          status: ChatsListStatus.success,
        ));
      } catch (e) {
        print('error : ${e.toString()}');
      }
    });
    on<AddChatsChannel>((event, emit) async {
      try {
        await _chatRepository.addChatChannel();
        // add(ChatsGetRequested());
      } catch (e) {
        print('error : ${e.toString()}');
      }
    });

    on<SendMessage>((event, emit) async {
      try {
        if (event.image != null) {
          print('event.image${event.image}');
          final imageUrl = await _chatRepository.uploadImage(
            event.image!,
            state.chatRoomSelected!.id,
          );
          final chatMessage = await _chatRepository.sendMessage(
            chatId: state.chatRoomSelected!.id,
            message: "image",
            imageUrl: imageUrl,
            sender: event.uid ?? "",
            receiver: state.chatRoomSelected!.members.toJson().keys.firstWhere(
                  (element) => element != event.uid,
                ),
          );
          log('chatMessage${chatMessage}');
          emit(state.copyWith(
            chatMessage: [...state.chatMessage, chatMessage],
            status: ChatsListStatus.sendedMessage,
          ));

          return;
        } else {
          final chatMessage = await _chatRepository.sendMessage(
            chatId: state.chatRoomSelected!.id,
            message: event.message,
            sender: event.uid ?? "",
            imageUrl: "",
            receiver: state.chatRoomSelected!.members.toJson().keys.firstWhere(
                  (element) => element != event.uid,
                ),
          );
          log('chatMessage${chatMessage}');

          emit(state.copyWith(
            chatMessage: [...state.chatMessage, chatMessage],
            status: ChatsListStatus.sendedMessage,
          ));
          return;
        }
      } catch (e) {
        print('error : ${e.toString()}');
      }
    });

    on<AddChatMessage>((event, emit) async {
      try {
        if (state.chatRoomSelected == null) {
          return;
        }

        // get timestamp of last message
        final lastMessageTimestamp =
            state.chatMessage.isNotEmpty ? state.chatMessage.last.timestamp : 0;

        if (event.chatMessage?.timestamp == lastMessageTimestamp) {
          return;
        }

        //   // add last message to state.chatMessage
        emit(state.copyWith(
          chatMessage: [...state.chatMessage, event.chatMessage!],
          imageList: [...state.imageList, event.chatMessage!.imageUrl],
        ));
        // }
      } catch (e) {
        print('error : ${e.toString()}');
      }
    });

    on<ChatInitialState>((event, emit) async {
      emit(state.copyWith(status: ChatsListStatus.initial));
    });
  }
}
