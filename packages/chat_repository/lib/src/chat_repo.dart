import 'dart:io';

import 'package:chat_repository/chat_repository.dart';

abstract class ChatRepository {
  Future<List<Chat>> getChatLists(String uid);

  Future<List<ChatMessage>> getChatMessages(
      {required String chatId, required int numberOfMessages});

  Future<void> addChatChannel();

  Future<ChatMessage> sendMessage({
    required String chatId,
    required String message,
    required String sender,
    required String receiver,
    required String imageUrl,
  });

  Future<String> uploadImage(File image, String chatId);
}
