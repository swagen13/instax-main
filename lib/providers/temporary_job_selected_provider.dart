import 'package:flutter/material.dart';
import 'package:job_repository/job_repository.dart';

class TemporarySelectedJobsProvider extends ChangeNotifier {
  List<Job> _selectedJobs = [];

  List<Job> get selectedJobs => _selectedJobs;

  void addSelectedJob(Job job) {
    _selectedJobs.add(job);
    notifyListeners();
  }

  void removeSelectedJob(Job job) {
    _selectedJobs.remove(job);
    notifyListeners();
  }
}

class TemporarySelectedSubJobsProvider extends ChangeNotifier {
  final List<Job> _selectedSubJobs = [];

  List<Job> get selectedSubJobs => _selectedSubJobs;

  void addSelectedSubJob(Job subJob) {
    _selectedSubJobs.add(subJob);
    notifyListeners();
  }

  void removeSelectedSubJob(Job subJob) {
    _selectedSubJobs.remove(subJob);
    notifyListeners();
  }
}
