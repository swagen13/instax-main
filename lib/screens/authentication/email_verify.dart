import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/app_state_bloc/app_state_bloc.dart';
import 'package:instax/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:instax/blocs/sign_in_bloc/sign_in_bloc.dart';

class EmailVerify extends StatelessWidget {
  const EmailVerify({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return BlocBuilder<AppStateBloc, AppState>(
      builder: (context, appState) {
        return BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, authState) {
            if (appState.state == AppStateStatus.resumed) {
              if (appState.isLoading) {
                user?.reload();
                print('user: $user');

                Future.delayed(const Duration(seconds: 1), () {
                  FirebaseAuth.instance.authStateChanges().listen((User? user) {
                    if (user?.emailVerified == true) {
                      print('user $user');
                      // show dialog
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Email verified'),
                            content: const Text('Your email has been verified'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'gender');
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Email not verified'),
                            content:
                                const Text('Your email has not been verified'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  });
                  context
                      .read<AppStateBloc>()
                      .add(const IsLoading(isLoading: false));
                });
              }
            } else if (appState.state == AppStateStatus.paused) {
              context
                  .read<AppStateBloc>()
                  .add(const IsLoading(isLoading: true));
            } else if (appState.state == AppStateStatus.inactive) {
              if (!appState.isLoading) {
                context
                    .read<AppStateBloc>()
                    .add(const IsLoading(isLoading: true));
              }
            }

            return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  actions: [
                    ElevatedButton.icon(
                        onPressed: () {
                          context.read<SignInBloc>().add(SignOutRequired());
                        },
                        icon: const Icon(Icons.logout),
                        label: const Text('Logout')),
                  ],
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Verify your email address',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<SignInBloc, SignInState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          onPressed: () {
                            context
                                .read<SignInBloc>()
                                .add(const EmailVerification());
                          },
                          child: appState.isLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white))
                              : const Text('Send verification email'),
                        );
                      },
                    ),
                  ],
                ));
          },
        );
      },
    );
  }
}
