part of 'chats_bloc.dart';

sealed class ChatsEvent extends Equatable {
  const ChatsEvent();

  @override
  List<Object> get props => [];
}

class ChatsGetRequested extends ChatsEvent {
  final String? uid;

  const ChatsGetRequested(this.uid);

  @override
  List<Object> get props => [uid!];
}

class ChatsSelected extends ChatsEvent {
  final Chat chatRoomSelected;

  const ChatsSelected(this.chatRoomSelected);

  @override
  List<Object> get props => [chatRoomSelected];
}

class GetChatsMessage extends ChatsEvent {
  final String chatMessage;

  const GetChatsMessage(this.chatMessage);

  @override
  List<Object> get props => [chatMessage];
}

class AddChatsChannel extends ChatsEvent {}

class SendMessage extends ChatsEvent {
  final String message;
  final String? uid;
  final File? image;

  const SendMessage(
    this.message,
    this.uid,
    this.image,
  );

  @override
  List<Object> get props => [message, image!];
}

class AddChatMessage extends ChatsEvent {
  final ChatMessage? chatMessage;

  const AddChatMessage({
    this.chatMessage,
  });

  @override
  List<Object> get props => [chatMessage!];
}

class ClearChatRoomSelectedState extends ChatsEvent {}

class ChatInitialState extends ChatsEvent {}
