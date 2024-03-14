import 'package:chat_repository/chat_repository.dart';
import 'package:equatable/equatable.dart';

enum ChatsListStatus {
  initial,
  success,
  loading,
  failure,
  sendedMessage,
  loadingMessage
}

class ChatsState extends Equatable {
  final ChatsListStatus status;
  final List<Chat> chatList;
  final Chat? chatRoomSelected;
  final List<ChatMessage> chatMessage;
  final List<String?> imageList;

  const ChatsState({
    this.status = ChatsListStatus.initial,
    this.chatList = const <Chat>[],
    this.chatRoomSelected,
    this.chatMessage = const <ChatMessage>[],
    this.imageList = const <String>[],
  });

  ChatsState copyWith({
    ChatsListStatus? status,
    List<Chat>? chatList,
    Chat? chatRoomSelected,
    List<ChatMessage>? chatMessage,
    List<String?>? imageList,
  }) {
    return ChatsState(
      status: status ?? this.status,
      chatList: chatList ?? this.chatList,
      chatRoomSelected: chatRoomSelected ?? this.chatRoomSelected,
      chatMessage: chatMessage ?? this.chatMessage,
      imageList: imageList ?? this.imageList,
    );
  }

  @override
  List<Object?> get props =>
      [status, chatList, chatRoomSelected, chatMessage, imageList];
}
