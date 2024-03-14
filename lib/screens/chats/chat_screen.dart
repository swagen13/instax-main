// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:instax/app_view.dart';
import 'package:instax/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:instax/blocs/chats_bloc/chats_bloc.dart';
import 'package:instax/blocs/chats_bloc/chats_state.dart';
import 'package:instax/blocs/image_bloc/image_bloc.dart';
import 'package:instax/blocs/image_bloc/image_event.dart';
import 'package:instax/blocs/image_bloc/image_state.dart';
import 'package:instax/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:instax/main.dart';
import 'package:instax/screens/chats/chat_list_screen.dart';
import 'package:instax/screens/chats/show_image.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  final BuildContext mainAppContext;

  ChatScreen({Key? key, required this.mainAppContext}) : super(key: key);

  final TextEditingController _messageController = TextEditingController();

  Future<void> _openGallery(BuildContext context) async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      final String path = appDocDir.path;
      final File newImage = File('$path/${image.name}');

      // Copy the selected image to the application directory
      await image.saveTo(newImage.path);

      // Add the selected image to the list
      context.read<ImageSelectionBloc>().add(
            ImageSelectedInChat(selectedImage: newImage),
          );
    }
  }

  final ScrollController _scrollController = ScrollController();

  bool _isLoadingMoreMessages = false; // Add a boolean flag

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<ChatsBloc, ChatsState>(
          builder: (context, state) {
            return Text(
              state.chatRoomSelected?.name ?? "Chat",
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // get chat id

              context.read<ChatsBloc>().add(const GetChatsMessage(
                    "-NrjHpy813R6LXKQ0hmV",
                  ));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatsBloc, ChatsState>(
              listener: (context, chatState) {
                if (chatState.chatMessage.isNotEmpty) {
                  log("get user data");
                  context.read<MyUserBloc>().add(
                      GetUserData(myUserId: chatState.chatMessage[0].sender));
                }
                if (chatState.status == ChatsListStatus.sendedMessage) {
                  log('message sended');
                  _messageController.clear(); // Clear the text field
                }
              },
              builder: (context, chatState) {
                log('contextChatScreen  ${mainAppContext.hashCode}');

                if (chatState.chatRoomSelected != null &&
                    chatState.status == ChatsListStatus.initial) {
                  final messageListener = MessageListener(
                      chatState.chatRoomSelected!.id, mainAppContext, context);
                  messageListener.startListening();
                  context
                      .read<ChatsBloc>()
                      .add(GetChatsMessage(chatState.chatRoomSelected!.id));
                }
                if (chatState.chatMessage != null &&
                        chatState.status == ChatsListStatus.success ||
                    chatState.status == ChatsListStatus.sendedMessage) {
                  final uid =
                      context.read<AuthenticationBloc>().state.user!.uid;
                  return NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      // get max scroll position
                      double maxScroll = scrollInfo.metrics.maxScrollExtent;

                      // get current scroll position
                      double currentScroll = scrollInfo.metrics.pixels;

                      // get 85% of the max scroll position
                      double delta = maxScroll * 0.90;

                      // if current scroll position is greater than 85% of the max scroll position
                      if (currentScroll >= delta) {
                        if (!_isLoadingMoreMessages) {
                          log("fetched more messages");
                          _isLoadingMoreMessages = true;

                          // Fetch more messages
                          context.read<ChatsBloc>().add(
                                GetChatsMessage(
                                  chatState.chatRoomSelected!.id,
                                ),
                              );
                        }
                      } else {
                        _isLoadingMoreMessages = false;
                      }

                      return false;
                    },
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          controller: _scrollController,
                          reverse: true,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Chat messages
                              ...chatState.chatMessage.map((message) {
                                // Check if the message is from the sender
                                bool isSender = message.sender == uid;

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Row(
                                    mainAxisAlignment: isSender
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: isSender
                                              ? CrossAxisAlignment.end
                                              : CrossAxisAlignment.start,
                                          children: [
                                            if (message.text == "image" &&
                                                message.imageUrl != null)
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ShowImageScreen(),
                                                    ),
                                                  );
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    message.imageUrl!,
                                                    width: 100,
                                                    loadingBuilder: (BuildContext
                                                            context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) {
                                                        // Image is fully loaded
                                                        return child;
                                                      } else {
                                                        // Image is still loading, display a loading indicator
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                                  0, 0, 10, 0),
                                                          child:
                                                              CircularProgressIndicator(
                                                            value: loadingProgress
                                                                        .expectedTotalBytes !=
                                                                    null
                                                                ? loadingProgress
                                                                        .cumulativeBytesLoaded /
                                                                    loadingProgress
                                                                        .expectedTotalBytes!
                                                                : null,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .secondary,
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ),
                                              )
                                            else
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: isSender
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Text(
                                                  message.text,
                                                  style: TextStyle(
                                                    color: isSender
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .onPrimary
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .onSecondary,
                                                  ),
                                                ),
                                              ),
                                            Row(
                                              mainAxisAlignment: isSender
                                                  ? MainAxisAlignment.end
                                                  : MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  // Format the message date based on the condition
                                                  _formatMessageDate(DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          message.timestamp)),
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                    fontSize: Theme.of(context)
                                                        .textTheme
                                                        .caption!
                                                        .fontSize,
                                                  ),
                                                ),
                                                // Display read status for sender's messages
                                                if (isSender && message.read)
                                                  Icon(
                                                    Icons
                                                        .done_all, // Change the icon according to read status
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    size: 12,
                                                  ),
                                              ],
                                            )
                                            // Inside the Text widget for displaying the message date:
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                        // Loading status bar overlay
                        if (chatState.status ==
                            ChatsListStatus
                                .loadingMessage) // Check if loading is in progress
                          Container(
                            padding: EdgeInsets.all(8),
                            height: 50,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          BlocBuilder<ImageSelectionBloc, ImageSelectionState>(
            builder: (context, imageState) {
              return Column(
                children: [
                  // Display selected images
                  if (imageState.selectedImageInChat.isNotEmpty)
                    Container(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imageState.selectedImageInChat.length,
                        itemBuilder: (context, index) {
                          final image = imageState.selectedImageInChat[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ShowImageScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          10), // Apply custom border radius
                                      image: DecorationImage(
                                        image: FileImage(image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // Positioned widget to place the close icon
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    // GestureDetector for handling tap on close icon
                                    onTap: () {
                                      // Remove the image from the list
                                      context.read<ImageSelectionBloc>().add(
                                            RemoveImageInChat(
                                                selectedImage: image),
                                          );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        // Button to add images
                        IconButton(
                          icon: const Icon(Icons.image),
                          onPressed: () {
                            _openGallery(context);
                          },
                        ),
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            decoration: const InputDecoration(
                              hintText: 'Type your message...',
                            ),
                            onSubmitted: (value) {
                              // Handle sending the message here
                              print('Message: $value');
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () async {
                            if (imageState.selectedImageInChat.isNotEmpty) {
                              if (imageState.selectedImageInChat.length > 1) {
                                // loop for uploading multiple images
                                for (var i = 0;
                                    i < imageState.selectedImageInChat.length;
                                    i++) {
                                  context.read<ChatsBloc>().add(
                                        SendMessage(
                                          _messageController.text,
                                          context
                                              .read<AuthenticationBloc>()
                                              .state
                                              .user!
                                              .uid,
                                          imageState.selectedImageInChat[i],
                                        ),
                                      );

                                  // remove the image from the list
                                  context.read<ImageSelectionBloc>().add(
                                        RemoveImageInChat(
                                            selectedImage: imageState
                                                .selectedImageInChat[i]),
                                      );
                                }
                              } else {
                                // upload single image
                                context.read<ChatsBloc>().add(
                                      SendMessage(
                                        _messageController.text,
                                        context
                                            .read<AuthenticationBloc>()
                                            .state
                                            .user!
                                            .uid,
                                        imageState.selectedImageInChat[0],
                                      ),
                                    );

                                // remove the image from the list
                                context.read<ImageSelectionBloc>().add(
                                      RemoveImageInChat(
                                          selectedImage: imageState
                                              .selectedImageInChat[0]),
                                    );
                              }
                            } else if (_messageController.text.isEmpty) {
                              return;
                            } else {
                              final authState =
                                  context.read<AuthenticationBloc>().state;
                              context.read<ChatsBloc>().add(
                                    SendMessage(_messageController.text,
                                        authState.user!.uid, null),
                                  );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

// Helper function to format the message date
String _formatMessageDate(DateTime messageDate) {
  // Get the current year
  int currentYear = DateTime.now().year;

  // Format the message date based on whether it's within this year or not
  if (messageDate.year == currentYear) {
    // Format for dates within this year: dd/mm HH:MM
    return DateFormat('dd/MM HH:mm').format(messageDate);
  } else {
    // Format for dates not within this year: dd/mm/yy HH:MM
    return DateFormat('dd/MM/yy HH:mm').format(messageDate);
  }
}
