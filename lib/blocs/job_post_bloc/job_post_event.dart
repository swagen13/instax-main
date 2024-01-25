import 'package:equatable/equatable.dart';

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
