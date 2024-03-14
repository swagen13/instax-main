// ignore_for_file: avoid_print, deprecated_member_use, no_leading_underscores_for_local_identifiers, library_prefixes, prefer_typing_uninitialized_variables, use_build_context_synchronously, prefer_const_constructors

import 'dart:developer';

import 'package:chat_repository/chat_repository.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:instax/blocs/app_state_bloc/app_state_bloc.dart';
import 'package:instax/blocs/authentication_bloc/authentication_bloc.dart'
    as AuthenticationBloc;
import 'package:instax/blocs/chats_bloc/chats_bloc.dart';
import 'package:instax/blocs/chats_bloc/chats_state.dart';
import 'package:instax/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:instax/firebase_options.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:user_repository/user_repository.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import 'app.dart';
import 'simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  LineSDK.instance.setup("2002245692").then((_) {
    print("LineSDK Prepared");
  });

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.getToken().then((value) {
    log("FCM Token: $value");
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen(_firebaseMessagingOnMessegeHandler);

  AwesomeNotifications().initialize(
    // use icon in assets folder
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white,
      )
    ],
  );
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AppStateBloc>(
          create: (context) => AppStateBloc(
            FirebaseUserRepository(),
          ),
        ),
        BlocProvider(create: (context) => ChatsBloc()),
        BlocProvider(
          create: (context) =>
              MyUserBloc(myUserRepository: FirebaseUserRepository()),
        ),
        BlocProvider(
            create: (context) => AuthenticationBloc.AuthenticationBloc(
                  myUserRepository: FirebaseUserRepository(),
                )),
      ],
      child: OverlaySupport.global(
        child: BlocBuilder<ChatsBloc, ChatsState>(
          builder: (mainAppContext, chatsState) {
            // Use a different variable name to store the context from BlocBuilder
            log('context chatsState  ${mainAppContext.hashCode}');
            log('ChatRoomSelected: ${chatsState.chatRoomSelected}');
            if (chatsState.chatRoomSelected != null) {
              // get user state from MyUserState
              final messageListener = MessageListener(
                  chatsState.chatRoomSelected!.id,
                  mainAppContext,
                  null); // Use the context from BlocBuilder
              messageListener.startListening();
            } else {
              final messageListener = MessageListener(
                  "", mainAppContext, null); // Use the context from BlocBuilder
              messageListener.startListening();
            }
            // Use a different variable name to store the context from Builder
            log('context  ${mainAppContext.hashCode}');
            final appLifecycleListener = AppLifecycleListener(
                mainAppContext); // Use the context from Builder

            WidgetsBinding.instance.addObserver(appLifecycleListener);
            return MainApp(
              mainAppContext: mainAppContext, // Use the context from Builder
              userRepository: FirebaseUserRepository(),
            );
          },
        ),
      ),
    ),
  );
}

class AppLifecycleListener extends WidgetsBindingObserver {
  final BuildContext context;

  AppLifecycleListener(this.context);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log('context  ${context.hashCode}');

    final appStateBloc = BlocProvider.of<AppStateBloc>(context);
    appStateBloc.add(UpdateAppLifecycleState(state));
    log('AppLifecycleState: $state');
  }
}

// handle the firebase messaging service
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // handle the message here
  log('Title ${message.notification?.title}');
  log('Body ${message.notification?.body}');
  log('Data ${message.data}');
}

Future<void> _firebaseMessagingOnMessegeHandler(RemoteMessage message) async {
  // handle foreground messages
  log('Title ${message.notification?.title}');
  log('Body ${message.notification?.body}');
  log('Data ${message.data}');
}

class PageTrackingNavigatorObserver extends NavigatorObserver {
  final BuildContext context;

  PageTrackingNavigatorObserver(this.context);

  Route<dynamic>? _currentRoute;

  Route<dynamic>? get currentRoute => _currentRoute;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _currentRoute = route;
    log('Current page didPush: ${route.settings.name}');
    _updateInChatState(route.settings.name, true);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _currentRoute = previousRoute;
    log('Current page didPop: ${previousRoute?.settings.name}');
    _updateInChatState(previousRoute?.settings.name, false);
  }

  void _updateInChatState(String? previousRouteName, bool isOnline) {
    log('Previous route: $previousRouteName');
    if (previousRouteName == 'chat') {
      log('Chat state');
      context.read<AppStateBloc>().add(const InChatStateChange(isOnline: true));
    } else {
      log('Not Chat state');
      context
          .read<AppStateBloc>()
          .add(const InChatStateChange(isOnline: false));
    }
  }
}

class MessageListener {
  final String chatId;
  final BuildContext buildContext;
  final BuildContext? chatContext;

  MessageListener(
    this.chatId,
    this.buildContext,
    this.chatContext,
  );

  void startListening() {
    if (chatId == "") return;
    log("listenMessages: $chatId");
    final DatabaseReference _messageRef =
        FirebaseDatabase.instance.reference().child('messages/$chatId');

    _messageRef.limitToLast(1).onChildAdded.listen((event) async {
      log('buildContext ${buildContext.hashCode}');
      // get path from _messageRef
      final path = event.snapshot.ref.path;
      log('_messageRef path: $path');
      log('event: ${event.snapshot.value}');

      final dynamic data = event.snapshot.value;

      final id = event.snapshot.key as String;
      final read = data['read'] as bool;
      final receiver = data['receiver'] as String;
      final sender = data['sender'] as String;
      final timestamp = data['timestamp'] as int;
      final imageUrl = data['imageUrl'] as String?;
      final text = data['text'] as String;

      // get receiver data
      final receiverRef = FirebaseDatabase.instance
          .reference()
          .child('users')
          .child(receiver)
          .get();

      // get receiver online data
      final receiverData = (await receiverRef).value as Map<dynamic, dynamic>;

      log('receiverData: $receiverData');

      // if the receiver is not online
      if (receiverData['inApp'] == false) {
        log('receiver is not online');
        return;
      }

      final ChatMessage chatMessage = ChatMessage(
        id: id,
        read: read,
        receiver: receiver,
        sender: sender,
        timestamp: timestamp,
        imageUrl: imageUrl,
        text: text,
      );

      // get uid from the authentication bloc
      final currentUser =
          buildContext.read<AuthenticationBloc.AuthenticationBloc>().state.user;

      log('uid: ${currentUser?.uid}');

      // if the receiver is the current user
      if (currentUser?.uid == sender) return;

      if (receiverData['inChat'] == false) {
        showSimpleNotification(
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      // You can set the sender's picture here
                      backgroundImage: NetworkImage(
                        currentUser?.photoURL ??
                            'https://via.placeholder.com/150',
                      ),
                      radius: 20, // Adjust the size as needed
                    ),
                    SizedBox(width: 10),
                    Text(
                      currentUser?.displayName ?? 'Unknown',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  text,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
          autoDismiss: true,
          slideDismiss: true,
          // remove background color
          background: Colors.transparent,
        );
        return;
      }

      chatContext
          ?.read<ChatsBloc>()
          .add(AddChatMessage(chatMessage: chatMessage));
    });
  }
}
