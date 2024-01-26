import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/Job_post_bloc/job_post_bloc.dart';
import 'package:instax/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:instax/blocs/jobs_bloc/jobs_bloc.dart';
import 'package:instax/blocs/jobs_bloc/jobs_event.dart';
import 'package:instax/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:instax/blocs/otp_bloc/otp_bloc.dart';
import 'package:instax/blocs/post_bloc/post_bloc.dart';
import 'package:instax/blocs/post_bloc/post_event.dart';
import 'package:instax/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:instax/blocs/theme_bloc/theme_bloc.dart';
import 'package:instax/blocs/theme_bloc/theme_state.dart';
import 'package:instax/providers/temporary_gender_provider.dart';
import 'package:instax/providers/temporary_job_selected_provider.dart';
import 'package:instax/providers/temporary_otp_provider.dart';
import 'package:instax/screens/authentication/login_screen.dart';
import 'package:instax/screens/authentication/otp_screen.dart';
import 'package:instax/screens/authentication/sign_in_screen.dart';
import 'package:instax/screens/home/home_screen.dart';
import 'package:instax/screens/home/post_screen.dart';
import 'package:instax/screens/profile/birthday_screen.dart';
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
    'gender': (context) => MultiBlocProvider(
          providers: [
            BlocProvider<MyUserBloc>(
              create: (context) => MyUserBloc(
                  myUserRepository:
                      context.read<AuthenticationBloc>().userRepository)
                ..add(GetMyUser(
                    myUserId:
                        context.read<AuthenticationBloc>().state.user!.uid)),
            ),
            ChangeNotifierProvider(create: (_) => TemporaryGenderProvider()),
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
    'sign_in': (context) => BlocProvider<SignInBloc>(
          create: (context) => SignInBloc(
            userRepository: context.read<AuthenticationBloc>().userRepository,
          ),
          child: const SignInScreen(),
        ),

    // BirthDate route
    'birthday': (context) => BlocProvider<MyUserBloc>(
          create: (context) => MyUserBloc(
              myUserRepository:
                  context.read<AuthenticationBloc>().userRepository)
            ..add(GetMyUser(
                myUserId: context.read<AuthenticationBloc>().state.user!.uid)),
          child: BirthDateScreen(),
        ),
    'name': (context) => BlocProvider<MyUserBloc>(
          create: (context) => MyUserBloc(
              myUserRepository:
                  context.read<AuthenticationBloc>().userRepository)
            ..add(GetMyUser(
                myUserId: context.read<AuthenticationBloc>().state.user!.uid)),
          child: DisplayNameScreen(),
        ),
    'image': (context) => MultiBlocProvider(
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
    'workType': (context) => BlocProvider<JobBloc>(
          create: (context) => JobBloc()..add(GetJob()),
          child: const WorkTypeScreen(),
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
    'otp_screen': (context) => MultiBlocProvider(
          providers: [
            BlocProvider<OTPBloc>(
              create: (context) => OTPBloc(),
            ),
            ChangeNotifierProvider(create: (_) => TemporaryOTPProvider()),
            ChangeNotifierProvider(create: (_) => TemporaryCounterProvider()),
          ],
          child: OTPScreen(),
        ),
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'InstaX',
          routes: routes,
          theme: ThemeData(
            fontFamily: 'NotoSansThai',
            useMaterial3: true,
            colorSchemeSeed: state.primaryColor,
          ),
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
                          myUserId: context
                              .read<AuthenticationBloc>()
                              .state
                              .user!
                              .uid)),
                  ),
                  ChangeNotifierProvider(
                      create: (_) => TemporaryGenderProvider()),
                  ChangeNotifierProvider(
                      create: (_) => TemporarySelectedJobsProvider()),
                  ChangeNotifierProvider(create: (_) => TemporaryOTPProvider()),
                ],
                child: WorkTypeScreen(),
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
