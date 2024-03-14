// ignore_for_file: deprecated_member_use, avoid_single_cascade_in_expression_statements

import 'dart:developer';
import 'dart:io';

import 'package:chat_repository/chat_repository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class FirebaseChatRepository implements ChatRepository {
  final database = FirebaseDatabase.instance.reference();

  @override
  Future<List<Chat>> getChatLists(String uid) async {
    try {
      // Get chat list from database
      final chatList = await database.child('chats').once();

      // Create a List<Chat> from the chat list
      final chatListObjects = <Chat>[];

      if (chatList.snapshot.value == null) {
        print('chatListObjects is empty');
        return [];
      }

      final Map<dynamic, dynamic> chatMap =
          chatList.snapshot.value as Map<dynamic, dynamic>;

      // select the chat that has the user id
      final List<MapEntry<dynamic, dynamic>> entries = chatMap.entries.toList();

      final List<MapEntry<dynamic, dynamic>> chatListMap = entries
          .where((element) => (element.value as Map)['members'][uid] != null)
          .toList();

      chatListMap.forEach((element) {
        final chat = Chat(
          id: element.key as String,
          lastMessage: element.value['last_message'] as String,
          members: Members(
            userMemberships: Map<String, bool>.from(
              element.value['members'] as Map,
            ),
          ),
          name: element.key as String,
          timestamp: element.value['timestamp'] as int,
        );
        chatListObjects.add(chat);
      });

      // Return the List<Chat>
      return chatListObjects;
    } catch (e) {
      // Handle any errors
      print('Error: $e');
      // Return an empty list in case of error
      return [];
    }
  }

  @override
  Future<List<ChatMessage>> getChatMessages({
    required String chatId,
    required int numberOfMessages,
  }) async {
    try {
      log("numberOfMessages ${numberOfMessages}");
      // Get chat messages from the database
      final chatMessages = await database
          .child('messages/$chatId')
          .limitToLast(numberOfMessages + 20)
          .once();

      final List<ChatMessage> chatMessageObjects = [];

      if (chatMessages.snapshot.value == null) {
        print('chatMessageObjects is empty');
        return chatMessageObjects;
      }

      final Map<dynamic, dynamic> chatMessageMap =
          chatMessages.snapshot.value as Map<dynamic, dynamic>;

      final List<MapEntry<dynamic, dynamic>> entries =
          chatMessageMap.entries.toList();

      // Sort the list based on the timestamp
      entries.sort((a, b) {
        final timestampA = (a.value as Map)['timestamp'] as int;
        final timestampB = (b.value as Map)['timestamp'] as int;
        return timestampA.compareTo(timestampB);
      });

      // Convert the sorted list back to a map
      final sortedChatMessageMap = Map.fromEntries(entries);

      sortedChatMessageMap.forEach((key, value) {
        if (value is Map) {
          final chatMessage = ChatMessage(
            id: key,
            read: value['read'] as bool,
            receiver: value['receiver'] as String,
            sender: value['sender'] as String,
            timestamp: value['timestamp'] as int,
            text: value['text'] as String,
            imageUrl: value['imageUrl'] as String?,
          );
          chatMessageObjects.add(chatMessage);
        } else {
          print('Invalid data format for chat message');
        }
      });

      // Return the List<ChatMessage>
      return chatMessageObjects;
    } catch (e) {
      // Handle any errors
      print('Error: $e');
      // Return an empty list in case of error
      return [];
    }
  }

  @override
  Future<void> addChatChannel() async {
    try {
      print('Add chat channel');
      // Add chat channel to database
      await database.child('chats').push().set({
        'last_message': '',
        'members': {
          'JddAOlnlZMdGd0WZCbnvEOyAbi53': true,
          'LobV7NYplXau2FZePpx9s4bWgzB2': true,
        },
      });
    } catch (e) {
      // Handle any errors
      print('Error: $e');
    }
  }

  @override
  Future<ChatMessage> sendMessage({
    required String chatId,
    required String message,
    required String sender,
    required String receiver,
    required String imageUrl,
  }) async {
    try {
      // Send message to database
      await database.child('messages/$chatId').push().set({
        'read': false,
        'receiver': receiver,
        'sender': sender,
        'text': message,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'imageUrl': imageUrl,
      });

      // Update last message in chat
      await database.child('chats/$chatId').update({
        'last_message': message,
      });

      // Update timestamp in chat
      await database.child('chats/$chatId').update({
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });

      final ChatMessage messageObject = ChatMessage(
        id: '',
        read: false,
        receiver: receiver,
        sender: sender,
        imageUrl: imageUrl,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        text: message,
      );

      // Return the ChatMessage
      return messageObject;
    } catch (e) {
      // Handle any errors
      print('Error: $e');
      rethrow;
    }
  }

  @override
  Future<String> uploadImage(File image, String chatId) async {
    try {
      String fileExtension = path.extension(image.path);
      String fileName =
          '$chatId-${DateTime.now().millisecondsSinceEpoch.toString()}$fileExtension';

      Reference reference =
          FirebaseStorage.instance.ref().child('chats/$chatId/$fileName');

      // remove . of the file extension
      fileExtension = fileExtension.replaceAll('.', '');

      // Create metadata with content type
      SettableMetadata metadata =
          SettableMetadata(contentType: 'image/$fileExtension');

      // Upload file with metadata
      UploadTask uploadTask = reference.putFile(
        image,
        metadata,
      );

      // Get the image URL
      TaskSnapshot storageTaskSnapshot = await uploadTask;
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

      // Return the image URL
      return downloadUrl;
    } catch (e) {
      // Handle any errors
      print('Error: $e');
      // Return an empty string in case of error
      return '';
    }
  }
}
