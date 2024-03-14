import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:instax/blocs/Job_post_bloc/job_post_bloc.dart';
import 'package:instax/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:instax/blocs/chats_bloc/chats_bloc.dart';
import 'package:instax/blocs/chats_bloc/chats_state.dart';
import 'package:instax/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:instax/blocs/otp_bloc/otp_bloc.dart';
import 'package:instax/blocs/post_bloc/post_bloc.dart';
import 'package:instax/blocs/post_bloc/post_event.dart';
import 'package:instax/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:instax/blocs/theme_bloc/theme_bloc.dart';
import 'package:instax/blocs/theme_bloc/theme_state.dart';
import 'package:instax/main.dart';
import 'package:instax/providers/temporary_gender_provider.dart';
import 'package:instax/providers/temporary_job_selected_provider.dart';
import 'package:instax/providers/temporary_otp_provider.dart';
import 'package:instax/screens/authentication/email_verify.dart';
import 'package:instax/screens/authentication/linking_account.dart';
import 'package:instax/screens/authentication/login_screen.dart';
import 'package:instax/screens/authentication/otp_screen.dart';
import 'package:instax/screens/authentication/otp_verify.dart';
import 'package:instax/screens/authentication/phone_verify.dart';
import 'package:instax/screens/authentication/sign_in_screen.dart';
import 'package:instax/screens/chats/chat_list_screen.dart';
import 'package:instax/screens/chats/chat_screen.dart';
import 'package:instax/screens/chats/show_image.dart';
import 'package:instax/screens/chats/show_image_gallery.dart';
import 'package:instax/screens/home/home_screen.dart';
import 'package:instax/screens/home/post_screen.dart';
import 'package:instax/screens/lifecycle/lifecycle_test.dart';
import 'package:instax/screens/notification/notification_test.dart';
import 'package:instax/screens/profile/birthday_screen.dart';
import 'package:instax/screens/profile/display_name_screen.dart';
import 'package:instax/screens/profile/favorite_job.dart';
import 'package:instax/screens/profile/favorite_works_selection_screen.dart';
import 'package:instax/screens/profile/gender_screen.dart';
import 'package:instax/screens/profile/image_upload_screen.dart';
import 'package:instax/screens/profile/work_type_screen.dart';
import 'package:instax/screens/social_share/post_detail.dart';
import 'package:post_repository/post_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyAppView extends StatelessWidget {
  final BuildContext mainAppContext;
  final Map<String, WidgetBuilder> routes;

  MyAppView({
    Key? key,
    required this.mainAppContext,
  }) : routes = {
          // Genders route
          'gender': (context) => MultiBlocProvider(
                providers: [
                  BlocProvider<MyUserBloc>(
                    create: (context) => MyUserBloc(
                        myUserRepository:
                            context.read<AuthenticationBloc>().userRepository)
                      ..add(GetMyUser(
                          myUserId: context
                              .read<AuthenticationBloc>()
                              .state
                              .user!
                              .uid)),
                  ),
                  ChangeNotifierProvider(
                      create: (_) => TemporaryGenderProvider()),
                ],
                child: GenderScreen(),
              ),
          // Home route
          'home': (context) => BlocProvider<PostBloc>(
                create: (context) =>
                    PostBloc(postRepository: FirebasePostRepository())
                      ..add(FetchPosts()),
                child: const HomeScreen(),
              ),
          // Post route
          'post': (context) => BlocProvider<PostBloc>(
                create: (context) =>
                    PostBloc(postRepository: FirebasePostRepository())
                      ..add(FetchPosts()),
                child: const PostScreen(),
              ),

          // Sign in route
          'sign_in': (context) => const SignInScreen(),

          // Login in route
          'login_in': (context) => const LoginScreen(),

          // BirthDate route
          'birthday': (context) => BlocProvider<MyUserBloc>(
                create: (context) => MyUserBloc(
                    myUserRepository:
                        context.read<AuthenticationBloc>().userRepository)
                  ..add(GetMyUser(
                      myUserId:
                          context.read<AuthenticationBloc>().state.user!.uid)),
                child: BirthDateScreen(),
              ),
          'name': (context) => BlocProvider<MyUserBloc>(
                create: (context) => MyUserBloc(
                    myUserRepository:
                        context.read<AuthenticationBloc>().userRepository)
                  ..add(GetMyUser(
                      myUserId:
                          context.read<AuthenticationBloc>().state.user!.uid)),
                child: DisplayNameScreen(),
              ),
          'image': (context) => MultiBlocProvider(
                providers: [
                  BlocProvider<MyUserBloc>(
                    create: (context) => MyUserBloc(
                        myUserRepository:
                            context.read<AuthenticationBloc>().userRepository)
                      ..add(GetMyUser(
                          myUserId: context
                              .read<AuthenticationBloc>()
                              .state
                              .user!
                              .uid)),
                  ),
                ],
                child: ImageUploadScreen(),
              ),
          'workType': (context) => const WorkTypeScreen(),
          'workType/favorite': (context) => FavoriteJob(),
          'workType/favorite/section': (context) => BlocProvider<JobPostBloc>(
                create: (context) => JobPostBloc(),
                child: const FavoriteWorksSelectionScreen(),
              ),
          'workType/favorite/bottomSheet': (context) => MultiBlocProvider(
                providers: [
                  ChangeNotifierProvider(
                      create: (_) => TemporarySelectedJobsProvider()),
                  ChangeNotifierProvider(
                      create: (_) => TemporarySelectedSubJobsProvider()),
                ],
                child: FavoriteJob(),
              ),
          'otp_screen': (context) => MultiBlocProvider(
                providers: [
                  BlocProvider<OTPBloc>(
                    create: (context) => OTPBloc(
                      context.read<AuthenticationBloc>().userRepository,
                    ),
                  ),
                  ChangeNotifierProvider(create: (_) => TemporaryOTPProvider()),
                  ChangeNotifierProvider(
                      create: (_) => TemporaryCounterProvider()),
                ],
                child: OTPScreen(),
              ),

          'otp_verify': (context) => MultiBlocProvider(
                providers: [
                  BlocProvider<OTPBloc>(
                    create: (context) => OTPBloc(
                      context.read<AuthenticationBloc>().userRepository,
                    ),
                  ),
                  ChangeNotifierProvider(create: (_) => TemporaryOTPProvider()),
                  ChangeNotifierProvider(
                      create: (_) => TemporaryCounterProvider()),
                ],
                child: OTPVerify(),
              ),

          'phoneVerify': (context) => const PhoneVerify(),

          'emailVerify': (context) => BlocProvider<SignInBloc>(
                create: (context) => SignInBloc(
                    userRepository:
                        context.read<AuthenticationBloc>().userRepository),
                child: const EmailVerify(),
              ),

          'linking_account': (context) => const LinkingAccountScreen(),

          'post_detail': (context) => const PostDetial(
                postId: '',
              ),

          'chat': (context) => ChatScreen(
                mainAppContext: mainAppContext,
              ),
          // 'chat': (context) => ChatScreen(),

          'show_image': (context) => const ShowImageScreen(),
          'show_image_gallery': (context) => const ShowImageGalleryScreen(
                imageSelected: '',
              ),

          'notification': (context) => const NotificationTestScreen(),
        };

  @override
  Widget build(BuildContext context) {
    log('context  ${mainAppContext.hashCode}');

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'InstaX',
          routes: routes,
          navigatorObservers: [
            PageTrackingNavigatorObserver(
              context,
            )
          ],
          theme: ThemeData(
            fontFamily: 'NotoSansThai',
            useMaterial3: true,
            colorSchemeSeed: state.primaryColor,
          ),
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
            initDynamicLinks(context);
            print('Authentication ${state.user?.emailVerified}');
            if (state.status == AuthenticationStatus.authenticated) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => MyUserBloc(
                        myUserRepository:
                            context.read<AuthenticationBloc>().userRepository)
                      ..add(GetMyUser(
                          myUserId: context
                              .read<AuthenticationBloc>()
                              .state
                              .user!
                              .uid)),
                  ),
                  ChangeNotifierProvider(
                      create: (_) => TemporaryGenderProvider()),
                  ChangeNotifierProvider(create: (_) => TemporaryOTPProvider()),
                ],
                child: ChatListScreen(
                  mainAppContext: mainAppContext,
                ),
              );
            } else {
              return const LoginScreen();
            }
          }),
        );
      },
    );
  }
}

void initDynamicLinks(BuildContext context) async {
  // Retrieve the initial dynamic link
  // Get any initial links
  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();

  _handleDeepLink(context, initialLink);

  // Listen for dynamic links while the app is running
  FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
    _handleDeepLink(context, dynamicLinkData);
  }).onError((error) {
    // Handle errors
  });
}

void _handleDeepLink(BuildContext context, PendingDynamicLinkData? data) {
  final Uri? deepLink = data?.link;

  print("deepLink: $deepLink");

  if (deepLink != null) {
    // Extract the postId from the deep link
    final postId = deepLink.queryParameters['postId'];

    print('postId: $postId');

    // Navigate to the post detail screen
    Navigator.pushNamed(context, 'post_detail', arguments: {'postId': postId});
  }
}
