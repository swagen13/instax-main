import 'package:bloc/bloc.dart';
import 'package:instax/blocs/subjob_bloc/subjob_event.dart';
import 'package:instax/blocs/subjob_bloc/subjob_state.dart';
import 'package:job_repository/job_repository.dart';

class SubJobBloc extends Bloc<SubJobEvent, SubJobState> {
  final JobRepository _jobRepository = FirebaseJobRepository();

  SubJobBloc() : super(SubJobState()) {
    on<GetSubjobByJobIds>((event, emit) async {
      try {
        print('event.jobIds : ${event.jobIds}');
        final subJobs = await _jobRepository.getSubjobByJobIds(event.jobIds);

        emit(state.copyWith(
          status: SubJobStatus.success,
          subJobs: subJobs,
        ));
      } catch (e) {
        print('error : ${e.toString()}');
        emit(state.copyWith(status: SubJobStatus.failure));
      }
    });
  }
}
