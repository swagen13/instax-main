import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_post_repository/job_post_repository.dart';
import 'package:job_post_repository/src/job_post_repo.dart';
import 'package:job_post_repository/src/models/job_post.dart';

class FirebaseJobPostRepository implements JobPostRepository {
  final jobPostCollection = FirebaseFirestore.instance.collection('jobPosts');

  @override
  Future<List<JobPost>> getJobPostBySubJobId(String subJobId) {
    try {
      return jobPostCollection.where('subJob', isEqualTo: subJobId).get().then(
          (value) => value.docs
              .map((e) =>
                  JobPost.fromEntity(JobPostEntity.fromDocument(e.data())))
              .toList());
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
