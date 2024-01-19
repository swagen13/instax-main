import 'package:equatable/equatable.dart';
import 'package:job_post_repository/job_post_repository.dart';

enum JobPostStatus { initial, success, loading, failure }

class JobPostState extends Equatable {
  const JobPostState({
    this.jobPosts = const <JobPost>[],
    this.status = JobPostStatus.initial,
    this.selectedJobPosts = const <JobPost>[],
  });

  final List<JobPost> jobPosts;
  final JobPostStatus status;
  final List<JobPost> selectedJobPosts;

  @override
  List<Object> get props => [jobPosts, status, selectedJobPosts];

  JobPostState copyWith({
    List<JobPost>? jobPosts,
    JobPostStatus? status,
    List<JobPost>? selectedJobPosts,
  }) {
    return JobPostState(
      jobPosts: jobPosts ?? this.jobPosts,
      status: status ?? this.status,
      selectedJobPosts: selectedJobPosts ?? this.selectedJobPosts,
    );
  }
}
