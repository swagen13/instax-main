import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:instax/blocs/theme_bloc/theme_event.dart';
import 'package:instax/blocs/theme_bloc/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(primaryColor: Colors.blue)) {
    // Load the saved color and update the bloc's state
    _loadSavedColor().then((color) {
      updateStateFromSavedColor(color);
    });

    on<UpdateThemeDataEvent>((event, emit) {
      //  update the bloc's state from ThemeDat
      emit(ThemeState(primaryColor: event.newThemeData.primaryColor));
    });
  }

  // Method to update the bloc's state from a saved color
  void updateStateFromSavedColor(Color savedColor) {
    // ignore: invalid_use_of_visible_for_testing_member
    emit(
      ThemeState(
        primaryColor: savedColor,
      ),
    );
  }

  // Method to load the saved color from SharedPreferences
  Future<Color> _loadSavedColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedColor = prefs.getInt('ThemeColor') ?? Colors.blue.value;
    print('savedColor: $savedColor');
    return Color(savedColor);
  }
}
