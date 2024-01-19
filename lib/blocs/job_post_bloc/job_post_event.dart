import 'package:equatable/equatable.dart';

sealed class JobPostEvent extends Equatable {
  const JobPostEvent();

  @override
  List<Object> get props => [];
}

class GetJobPosts extends JobPostEvent {
  final String subJobIds;

  const GetJobPosts(this.subJobIds);

  @override
  List<Object> get props => [subJobIds];
}
