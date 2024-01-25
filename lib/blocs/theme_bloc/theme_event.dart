import 'package:flutter/material.dart';

abstract class ThemeEvent {}

class ToggleThemeEvent extends ThemeEvent {}

class ChangeColorEvent extends ThemeEvent {
  final Color newColor;

  ChangeColorEvent(this.newColor);
}

class UpdateThemeDataEvent extends ThemeEvent {
  final ThemeData newThemeData;

  UpdateThemeDataEvent(this.newThemeData);
}
