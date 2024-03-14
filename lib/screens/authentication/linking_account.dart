import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:instax/blocs/my_user_bloc/my_user_state.dart';
import 'package:instax/blocs/phone_number_bloc/phone_number_bloc.dart';
import 'package:instax/blocs/phone_number_bloc/phone_number_event.dart';
import 'package:instax/blocs/sign_in_bloc/sign_in_bloc.dart';

class LinkingAccountScreen extends StatelessWidget {
  const LinkingAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state.status == SignInStatus.failure) {
          if (state.errorMessage == "second-factor-required") {
            context
                .read<SignInBloc>()
                .add(SendVerificationMessage(state.multiFactorResolver));
          }
        } else if (state.verificationId != null &&
            state.status == SignInStatus.progress) {
          context
              .read<PhoneNumberBloc>()
              .add(SetVerificationId(state.verificationId!));
          Navigator.pushNamed(context, 'otp_verify');
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Link your account with Facebook',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 20),
            BlocBuilder<MyUserBloc, MyUserState>(
              builder: (context, state) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    context.read<SignInBloc>().add(const SignOutRequired());

                    Navigator.pop(context);
                  },
                  child: const Text('Back to Sign In'),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                context.read<SignInBloc>().add(const LinkingAccount());
              },
              child: const Text('Link Account'),
            ),
          ],
        ));
      },
    );
  }
}
