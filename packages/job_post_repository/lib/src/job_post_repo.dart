import 'package:job_post_repository/job_post_repository.dart';

abstract class JobPostRepository {
  Future<List<JobPost>> getJobPostBySubJobId(String subJobId);

  Future<List<JobPost>> getJobPostByUserId(String userId);

  Future<List<JobPost>> selectedPost(JobPost jobPost, String? userId);
}
