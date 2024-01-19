import 'package:job_post_repository/src/models/models.dart';

abstract class JobPostRepository {
  Future<List<JobPost>> getJobPostBySubJobId(String subJobId);
}
