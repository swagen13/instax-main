import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/phone_number_bloc/phone_number_bloc.dart';
import 'package:instax/blocs/phone_number_bloc/phone_number_event.dart';
import 'package:instax/blocs/sign_in_bloc/sign_in_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        print('state is $state');
        if (state.status == SignInStatus.failure) {
          if (state.errorMessage ==
              "account-exists-with-different-credential") {
            Navigator.pushNamed(context, 'linking_account');
          } else if (state.errorMessage == "second-factor-required") {
            print('second-factor-required');
            print('error is ${state.errorMessage}');
            context
                .read<SignInBloc>()
                .add(SendVerificationMessage(state.multiFactorResolver));
          }
        }

        if (state.verificationId != null &&
            state.status == SignInStatus.progress) {
          context
              .read<PhoneNumberBloc>()
              .add(SetVerificationId(state.verificationId!));
          Navigator.pushNamed(context, 'otp_verify');
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.7),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 150),
                      Text(
                        'เข้าสู่ระบบ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'เข้าสู่ระบบเพื่อหางานหรือจ้างงานได้ก่อนใคร',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              Theme.of(context).textTheme.bodyLarge?.fontSize,
                        ),
                      ),
                      const SizedBox(height: 150),
                      ElevatedButton.icon(
                        onPressed: () {
                          context
                              .read<SignInBloc>()
                              .add(const SignInWithFacebookRequired());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 66, 103, 178),
                          minimumSize: const Size(350, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        icon: const Image(
                          image: AssetImage('assets/images/facebook_icon.png'),
                          width: 50,
                          alignment: Alignment.centerLeft,
                        ),
                        label: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            'เข้าสู่ระบบด้วย Facebook',
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.fontSize,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          context
                              .read<SignInBloc>()
                              .add(const SignInWithGoogle());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 66, 133, 244),
                          minimumSize: const Size(350, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        icon: Container(
                          width: 40,
                          color: Colors.white,
                          child: const Center(
                            child: Image(
                              image:
                                  AssetImage('assets/images/google_icon.png'),
                              width: 40,
                            ),
                          ),
                        ),
                        label: Padding(
                          padding: EdgeInsets.only(left: 35),
                          child: Text(
                            'เข้าสู่ระบบด้วย Google',
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.fontSize,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          context
                              .read<SignInBloc>()
                              .add(const SignInWithLine());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 0, 184, 0),
                          minimumSize: const Size(350, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        icon: const Image(
                          image: AssetImage('assets/images/line_icon.png'),
                          width: 50,
                        ),
                        label: Padding(
                          padding: EdgeInsets.only(left: 40),
                          child: Text(
                            'เข้าสู่ระบบด้วย Line',
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.fontSize,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<SignInBloc>()
                              .add(const SignInWithAnonymously());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.0),
                          minimumSize: const Size(350, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Text(
                          "เข้าสู่ระบบแบบไม่ระบุตัวตน",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.fontSize),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          "เมื่อ เข้าสู่ระบบ ข้าพเจ้ารับทราบ และตกลงตาม นโยบายความ \n เป็นส่วนตัว นโยบายคุกกี้ และเงื่อนไขการใช้งาน ของ บริษัท แล้ว",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                Theme.of(context).textTheme.bodyLarge?.fontSize,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
