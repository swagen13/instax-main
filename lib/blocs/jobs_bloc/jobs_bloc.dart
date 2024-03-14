import 'package:bloc/bloc.dart';
import 'package:instax/blocs/jobs_bloc/jobs_event.dart';
import 'package:instax/blocs/jobs_bloc/jobs_state.dart';
import 'package:job_repository/job_repository.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final JobRepository _jobRepository = FirebaseJobRepository();

  JobBloc() : super(JobState()) {
    on<GetJob>((event, emit) async {
      try {
        final jobs = await _jobRepository.getJob();
        emit(state.copyWith(status: JobStatus.success, jobs: jobs));
      } catch (e) {
        print('error : ${e.toString()}');
        emit(state.copyWith(status: JobStatus.failure));
      }
    });

    on<JobSelected>((event, emit) async {
      emit(state.copyWith(
        status: JobStatus.loading,
      ));
      try {
        emit(state.copyWith(
            status: JobStatus.success, selectedJobs: event.selectedJobs));
      } catch (e) {
        print('error : ${e.toString()}');
        emit(state.copyWith(status: JobStatus.failure));
      }
    });

    on<SubJobSelected>((event, emit) async {
      emit(state.copyWith(
        status: JobStatus.loading,
      ));
      try {
        emit(state.copyWith(
            status: JobStatus.success, selectedSubJobs: event.selectedSubJobs));
      } catch (e) {
        print('error : ${e.toString()}');
        emit(state.copyWith(status: JobStatus.failure));
      }
    });
  }
}
