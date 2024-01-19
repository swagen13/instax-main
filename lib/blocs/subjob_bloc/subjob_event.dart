import 'package:equatable/equatable.dart';

abstract class SubJobEvent extends Equatable {
  const SubJobEvent();

  @override
  List<Object> get props => [];
}

class GetSubjobByJobIds extends SubJobEvent {
  final List<String> jobIds;

  const GetSubjobByJobIds({required this.jobIds});

  @override
  List<Object> get props => [jobIds];
}
