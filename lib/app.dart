// ignore_for_file: avoid_renaming_method_parameters

import 'dart:developer';

import 'package:chat_repository/chat_repository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:instax/blocs/Job_post_bloc/job_post_bloc.dart';
import 'package:instax/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:instax/blocs/chats_bloc/chats_bloc.dart';
import 'package:instax/blocs/chats_bloc/chats_state.dart';
import 'package:instax/blocs/image_bloc/image_bloc.dart';
import 'package:instax/blocs/jobs_bloc/jobs_bloc.dart';
import 'package:instax/blocs/jobs_bloc/jobs_event.dart';
import 'package:instax/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:instax/blocs/phone_number_bloc/phone_number_bloc.dart';
import 'package:instax/blocs/post_bloc/post_bloc.dart';
import 'package:instax/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:instax/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:instax/blocs/subjob_bloc/subjob_bloc.dart';
import 'package:instax/blocs/theme_bloc/theme_bloc.dart';
import 'package:instax/main.dart';
import 'package:instax/providers/temporary_job_selected_provider.dart';
import 'package:instax/providers/temporary_select_post_provider.dart';
import 'package:instax/providers/temporary_username_password_provider.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:post_repository/post_repository.dart';
import 'package:provider/provider.dart';
import 'package:user_repository/user_repository.dart';

import 'app_view.dart';

class MainApp extends StatelessWidget {
  final BuildContext mainAppContext;
  final UserRepository userRepository;

  const MainApp(
      {Key? key, required this.mainAppContext, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // get chat bloc state
    return BlocBuilder<ChatsBloc, ChatsState>(
      builder: (context, chatsState) {
        log('context  ${mainAppContext.hashCode}');

        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationBloc>(
              create: (context) => AuthenticationBloc(
                myUserRepository: userRepository,
              ),
            ),
            BlocProvider<SignInBloc>(
              create: (context) => SignInBloc(
                userRepository:
                    context.read<AuthenticationBloc>().userRepository,
              ),
            ),
            BlocProvider<SignUpBloc>(
              create: (context) => SignUpBloc(
                userRepository: userRepository,
              ),
            ),
            BlocProvider(
                create: (context) =>
                    PostBloc(postRepository: FirebasePostRepository())),
            BlocProvider(
                create: (context) =>
                    MyUserBloc(myUserRepository: userRepository)),
            BlocProvider(
              create: (context) => ImageSelectionBloc(
                userRepository,
              ),
            ),
            BlocProvider(
              create: (context) => ThemeBloc(),
            ),
            BlocProvider(create: (context) => JobBloc()),
            BlocProvider(create: (context) => SubJobBloc()),
            BlocProvider(create: (context) => JobPostBloc()),
            BlocProvider(
                create: (context) => PhoneNumberBloc(
                      userRepository,
                    )),
            BlocProvider<JobBloc>(
              create: (context) => JobBloc()..add(GetJob()),
            ),
            ChangeNotifierProvider(
                create: (_) => TemporarySelectedJobsProvider()),
            ChangeNotifierProvider(
                create: (_) => TemporarySelectedSubJobsProvider()),
            ChangeNotifierProvider(create: (_) => TemporaryUsernameProvider()),
            ChangeNotifierProvider(create: (_) => TemporaryPasswordProvider()),
            ChangeNotifierProvider(
              create: (context) => SelectedTasksProvider(),
            ),
            BlocProvider(
                create: (context) => PhoneNumberBloc(
                      userRepository,
                    )),
            BlocProvider(
              create: (context) => ChatsBloc()
                ..add(ChatsGetRequested(
                    context.read<AuthenticationBloc>().state.user!.uid)),
            ),
          ],
          child: MyAppView(
            mainAppContext: mainAppContext,
          ),
        );
      },
    );
  }
}
