import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:job_repository/job_repository.dart';

abstract class JobEvent extends Equatable {
  const JobEvent();

  @override
  List<Object> get props => [];
}

class GetJob extends JobEvent {}

class JobSelected extends JobEvent {
  final List<Job> selectedJobs;

  const JobSelected({required this.selectedJobs});

  @override
  List<Object> get props => [selectedJobs];
}

class SubJobSelected extends JobEvent {
  final List<SubJob> selectedSubJobs;

  const SubJobSelected({required this.selectedSubJobs});

  @override
  List<Object> get props => [selectedSubJobs];
}
