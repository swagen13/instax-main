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
  final List<SubJob> _selectedSubJobs = [];

  List<SubJob> get selectedSubJobs => _selectedSubJobs;

  void addSelectedSubJob(SubJob subJob) {
    _selectedSubJobs.add(subJob);
    notifyListeners();
  }

  void removeSelectedSubJob(SubJob subJob) {
    _selectedSubJobs.remove(subJob);
    notifyListeners();
  }
}
