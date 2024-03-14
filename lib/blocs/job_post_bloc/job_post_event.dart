import 'package:equatable/equatable.dart';
import 'package:job_post_repository/job_post_repository.dart';

sealed class JobPostEvent extends Equatable {
  const JobPostEvent();

  @override
  List<Object> get props => [];
}

class JobPostsGetRequested extends JobPostEvent {
  final String subJobIds;

  const JobPostsGetRequested(this.subJobIds);

  @override
  List<Object> get props => [subJobIds];
}

class getJobPostByUserId extends JobPostEvent {
  final String userId;

  const getJobPostByUserId(this.userId);

  @override
  List<Object> get props => [userId];
}

class SelectJobPosts extends JobPostEvent {
  final JobPost post;
  final String? userId;

  const SelectJobPosts(this.post, this.userId);

  @override
  List<Object> get props => [post];
}
