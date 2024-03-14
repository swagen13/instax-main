import 'package:flutter/material.dart';

class SelectedTasksProvider extends ChangeNotifier {
  List<String> _selectedTasks = [];

  List<String> get selectedTasks => _selectedTasks;

  void addTask(String task) {
    _selectedTasks.add(task);
    print(selectedTasks);
    notifyListeners();
  }

  void removeTask(String task) {
    _selectedTasks.remove(task);
    notifyListeners();
  }
}
