import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:instax/blocs/chats_bloc/chats_bloc.dart';
import 'package:instax/blocs/chats_bloc/chats_state.dart';

class ChatListScreen extends StatelessWidget {
  final BuildContext mainAppContext;

  const ChatListScreen({Key? key, required this.mainAppContext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('context  ${mainAppContext.hashCode}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {
              context.read<ChatsBloc>().add(
                    AddChatsChannel(),
                  );
            },
          ),
        ],
      ),
      body: Center(
        child: BlocConsumer<ChatsBloc, ChatsState>(
          listener: (context, state) {
            // if (state.chatRoomSelected != null) {
            //   log('state.chatRoomSelected.id ${state.chatRoomSelected!.id}'); // New Line

            // }
          },
          builder: (context, state) {
            checkNotificationPermission(context);

            if (state.status == ChatsListStatus.success) {
              return ListView.builder(
                itemCount: state.chatList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.chatList[index].name),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    subtitle: Text(state.chatList[index].lastMessage == "Call"
                        ? "Call"
                        : state.chatList[index].lastMessage),
                    onTap: () {
                      log("ChatRoomSelected ${state.chatList[index].id}");
                      context.read<ChatsBloc>().add(
                            ChatsSelected(state.chatList[index]),
                          );

                      Navigator.pushNamed(
                        context,
                        'chat',
                        arguments: mainAppContext,
                      );
                    },
                  );
                },
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

void checkNotificationPermission(BuildContext context) async {
  if (!await AwesomeNotifications().isNotificationAllowed()) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Allow Notifications'),
        content: const Text(
            'Please allow notifications to receive messages and calls'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await AwesomeNotifications()
                  .requestPermissionToSendNotifications();
              Navigator.pop(context);
            },
            child: const Text('Allow'),
          ),
        ],
      ),
    );
  }
}
