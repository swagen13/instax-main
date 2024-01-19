import 'package:bloc/bloc.dart';
import 'package:instax/blocs/Job_post_bloc/job_post_event.dart';
import 'package:instax/blocs/Job_post_bloc/job_post_state.dart';
import 'package:job_post_repository/job_post_repository.dart';

class JobPostBloc extends Bloc<JobPostEvent, JobPostState> {
  final JobPostRepository _jobPostRepository = FirebaseJobPostRepository();

  JobPostBloc() : super(JobPostState()) {
    on<GetJobPosts>((event, emit) async {
      try {
        // check if the subJobId is already selected
        if (state.jobPosts
            .where((element) => element.subJob == event.subJobIds)
            .isEmpty) {
          // if not selected, get the jobPosts from the repository
          final jobPosts =
              await _jobPostRepository.getJobPostBySubJobId(event.subJobIds);
          // add the jobPosts to the jobPosts
          emit(state.copyWith(
              jobPosts: [...state.jobPosts, ...jobPosts],
              status: JobPostStatus.success));
        } else {
          // if already selected, remove the jobPosts from the jobPosts
          emit(state.copyWith(jobPosts: [
            ...state.jobPosts
                .where((element) => element.subJob != event.subJobIds)
          ], status: JobPostStatus.success));
        }
      } catch (e) {
        print('error : ${e.toString()}');
        emit(state.copyWith(status: JobPostStatus.failure));
      }
    });
  }
}
