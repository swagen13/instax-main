import 'package:bloc/bloc.dart';
import 'package:instax/blocs/Job_post_bloc/job_post_state.dart';
import 'package:instax/blocs/job_post_bloc/job_post_event.dart';
import 'package:job_post_repository/job_post_repository.dart';

class JobPostBloc extends Bloc<JobPostEvent, JobPostState> {
  final JobPostRepository _jobPostRepository = FirebaseJobPostRepository();

  JobPostBloc() : super(const JobPostState()) {
    on<JobPostsGetRequested>((event, emit) async {
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
            status: JobPostStatus.success,
          ));
        } else {
          // if already selected, remove the jobPosts from the jobPosts
          emit(state.copyWith(
            jobPosts: [
              ...state.jobPosts
                  .where((element) => element.subJob != event.subJobIds)
            ],
            status: JobPostStatus.success,
          ));
        }
      } catch (e) {
        print('error : ${e.toString()}');
        emit(state.copyWith(status: JobPostStatus.failure));
      }
    });

    // getJobPostByUserId
    on<getJobPostByUserId>((event, emit) async {
      try {
        // get the jobPosts from the repository
        final selectedJobPosts =
            await _jobPostRepository.getJobPostByUserId(event.userId);

        print('getJobPostByUserId : $selectedJobPosts');
        // add the jobPosts to the jobPosts
        emit(state.copyWith(
            selectedJobPosts: selectedJobPosts, status: JobPostStatus.success));
      } catch (e) {
        print('error : ${e.toString()}');
        emit(state.copyWith(status: JobPostStatus.failure));
      }
    });

    on<SelectJobPosts>((event, emit) async {
      emit(state.copyWith(status: JobPostStatus.loading));
      try {
        // update the jobPost
        final selectedJobPosts =
            await _jobPostRepository.selectedPost(event.post, event.userId);

        print('selectedJobPosts isss : ${selectedJobPosts.length}');

        // set the  selectedJobPosts to the jobPosts
        emit(state.copyWith(
            selectedJobPosts: selectedJobPosts, status: JobPostStatus.success));

        print('state.selectedJobPosts is : ${selectedJobPosts.length}');
      } catch (e) {
        print('error : ${e.toString()}');
        emit(state.copyWith(status: JobPostStatus.failure));
      }
    });
  }
}
