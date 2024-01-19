import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/Job_post_bloc/job_post_bloc.dart';
import 'package:instax/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:instax/blocs/image_bloc/image_bloc.dart';
import 'package:instax/blocs/jobs_bloc/jobs_bloc.dart';
import 'package:instax/blocs/jobs_bloc/jobs_event.dart';
import 'package:instax/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:instax/blocs/post_bloc/post_bloc.dart';
import 'package:instax/blocs/post_bloc/post_event.dart';
import 'package:instax/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:instax/providers/temporary_gender_provider.dart';
import 'package:instax/providers/temporary_job_selected_provider.dart';
import 'package:instax/screens/authentication/onboard_screen.dart';
import 'package:instax/screens/authentication/sign_in_screen.dart';
import 'package:instax/screens/profile/birthday_screen.dart';
import 'package:instax/screens/home/home_screen.dart';
import 'package:instax/screens/home/post_screen.dart';
import 'package:instax/screens/profile/display_name_screen.dart';
import 'package:instax/screens/profile/favorite_job.dart';
import 'package:instax/screens/profile/favorite_works_selection_screen.dart';
import 'package:instax/screens/profile/gender_screen.dart';
import 'package:instax/screens/profile/image_upload_screen.dart';
import 'package:instax/screens/profile/work_type_screen.dart';
import 'package:post_repository/post_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

class MyAppView extends StatelessWidget {
  MyAppView({super.key});

  final routes = {
    // Genders route
    // '/gender': (context) => BlocProvider<MyUserBloc>(
    //       create: (context) => MyUserBloc(
    //           myUserRepository:
    //               context.read<AuthenticationBloc>().userRepository)
    //         ..add(GetMyUser(
    //             myUserId: context.read<AuthenticationBloc>().state.user!.uid)),
    //       child: GenderScreen(),
    //     ),
    // Home route
    '/home': (context) => BlocProvider<PostBloc>(
          create: (context) =>
              PostBloc(postRepository: FirebasePostRepository())
                ..add(FetchPosts()),
          child: const HomeScreen(),
        ),
    // Post route
    '/post': (context) => BlocProvider<PostBloc>(
          create: (context) =>
              PostBloc(postRepository: FirebasePostRepository())
                ..add(FetchPosts()),
          child: const PostScreen(),
        ),

    // Sign in route
    '/sign_in': (context) => BlocProvider<SignInBloc>(
          create: (context) => SignInBloc(
            userRepository: context.read<AuthenticationBloc>().userRepository,
          ),
          child: const SignInScreen(),
        ),

    // BirthDate route
    '/birthday': (context) => BlocProvider<MyUserBloc>(
          create: (context) => MyUserBloc(
              myUserRepository:
                  context.read<AuthenticationBloc>().userRepository)
            ..add(GetMyUser(
                myUserId: context.read<AuthenticationBloc>().state.user!.uid)),
          child: BirthDateScreen(),
        ),
    '/name': (context) => BlocProvider<MyUserBloc>(
          create: (context) => MyUserBloc(
              myUserRepository:
                  context.read<AuthenticationBloc>().userRepository)
            ..add(GetMyUser(
                myUserId: context.read<AuthenticationBloc>().state.user!.uid)),
          child: DisplayNameScreen(),
        ),
    '/image': (context) => MultiBlocProvider(
          providers: [
            BlocProvider<MyUserBloc>(
              create: (context) => MyUserBloc(
                  myUserRepository:
                      context.read<AuthenticationBloc>().userRepository)
                ..add(GetMyUser(
                    myUserId:
                        context.read<AuthenticationBloc>().state.user!.uid)),
            ),
          ],
          child: ImageUploadScreen(),
        ),
    '/workType': (context) => BlocProvider<JobBloc>(
          create: (context) => JobBloc()..add(GetJob()),
          child: WorkTypeScreen(),
        ),
    'workType/favorite': (context) => MultiBlocProvider(
          providers: [
            ChangeNotifierProvider(
                create: (_) => TemporarySelectedJobsProvider()),
            ChangeNotifierProvider(
                create: (_) => TemporarySelectedSubJobsProvider()),
          ],
          child: FavoriteJob(),
        ),
    'workType/favorite/section': (context) => BlocProvider<JobPostBloc>(
          create: (context) => JobPostBloc(),
          child: FavoriteWorksSelectionScreen(),
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
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InstaX',
      theme: ThemeData(
        fontFamily: "NotoSansThai",
        colorScheme: const ColorScheme.light(
            background: Colors.white,
            onBackground: Colors.black,
            primary: Color.fromRGBO(206, 147, 216, 1),
            onPrimary: Colors.black,
            secondary: Color.fromRGBO(244, 143, 177, 1),
            onSecondary: Colors.white,
            tertiary: Color.fromRGBO(255, 204, 128, 1),
            error: Colors.red,
            outline: Color(0xFF424242)),
      ),
      routes: routes,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SignInBloc(
                    userRepository:
                        context.read<AuthenticationBloc>().userRepository),
              ),
              BlocProvider(
                create: (context) => MyUserBloc(
                    myUserRepository:
                        context.read<AuthenticationBloc>().userRepository)
                  ..add(GetMyUser(
                      myUserId:
                          context.read<AuthenticationBloc>().state.user!.uid)),
              ),
              ChangeNotifierProvider(create: (_) => TemporaryGenderProvider()),
              ChangeNotifierProvider(
                  create: (_) => TemporarySelectedJobsProvider()),
            ],
            child: WorkTypeScreen(),
          );
        } else {
          return const SignInScreen();
        }
      }),
    );
  }
}
