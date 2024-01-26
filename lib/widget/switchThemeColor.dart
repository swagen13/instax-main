import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/theme_bloc/theme_bloc.dart';
import 'package:instax/blocs/theme_bloc/theme_event.dart';
import 'package:instax/blocs/theme_bloc/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SwitchThemeColor extends StatelessWidget {
  const SwitchThemeColor({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Row(
          children: [
            TextButton(
              onPressed: () {
                // set the color to share preference
                SharedPreferences.getInstance().then((prefs) {
                  prefs.setInt(
                      'ThemeColor', Color.fromRGBO(0, 86, 210, 1).value);
                });
                context.read<ThemeBloc>().add(UpdateThemeDataEvent(
                      ThemeData(
                        primaryColor: Color.fromRGBO(0, 86, 210, 1),
                      ),
                    ));
              },
              child: const Text(
                'blue',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            TextButton(
                onPressed: () {
                  // set the color to share preference
                  SharedPreferences.getInstance().then((prefs) {
                    prefs.setInt('ThemeColor', Colors.yellow.value);
                  });
                  context.read<ThemeBloc>().add(UpdateThemeDataEvent(
                        ThemeData(
                          primaryColor: Colors.yellow,
                        ),
                      ));
                },
                child: const Text(
                  'yellow',
                  style: TextStyle(color: Colors.yellow),
                )),
            const SizedBox(width: 10),
          ],
        );
      },
    );
  }
}
