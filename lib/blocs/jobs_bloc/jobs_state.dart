import 'package:equatable/equatable.dart';
import 'package:job_repository/job_repository.dart';

enum JobStatus { initial, success, loading, failure }

class JobState extends Equatable {
  const JobState({
    this.jobs = const <Job>[],
    this.status = JobStatus.initial,
    this.selectedJobs = const <Job>[],
    this.selectedSubJobs = const <Job>[],
  });

  final List<Job> jobs;
  final JobStatus status;
  final List<Job> selectedJobs;
  final List<Job> selectedSubJobs;

  @override
  List<Object> get props => [jobs, status, selectedJobs, selectedSubJobs];

  JobState copyWith({
    List<Job>? jobs,
    JobStatus? status,
    List<Job>? selectedJobs,
    List<Job>? selectedSubJobs,
  }) {
    return JobState(
      jobs: jobs ?? this.jobs,
      status: status ?? this.status,
      selectedJobs: selectedJobs ?? this.selectedJobs,
      selectedSubJobs: selectedSubJobs ?? this.selectedSubJobs,
    );
  }
}
