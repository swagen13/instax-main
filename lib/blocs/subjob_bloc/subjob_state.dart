import 'package:equatable/equatable.dart';
import 'package:job_repository/job_repository.dart';

enum SubJobStatus { initial, success, loading, failure }

class SubJobState extends Equatable {
  const SubJobState({
    this.subJobs = const <SubJob>[],
    this.status = SubJobStatus.initial,
  });

  final List<SubJob> subJobs;
  final SubJobStatus status;

  @override
  List<Object> get props => [subJobs, status];

  SubJobState copyWith({
    List<SubJob>? subJobs,
    SubJobStatus? status,
  }) {
    return SubJobState(
      subJobs: subJobs ?? this.subJobs,
      status: status ?? this.status,
    );
  }
}
