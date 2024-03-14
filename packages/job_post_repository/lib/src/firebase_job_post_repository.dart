import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_post_repository/job_post_repository.dart';

class FirebaseJobPostRepository implements JobPostRepository {
  final jobPostCollection = FirebaseFirestore.instance.collection('jobPosts');
  final usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<List<JobPost>> getJobPostBySubJobId(String subJobId) async {
    try {
      final querySnapshot =
          await jobPostCollection.where('subJob', isEqualTo: subJobId).get();
      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return JobPost(
          id: doc.id,
          description1: data['description1'] ?? '',
          description2: data['description2'] ?? '',
          subJob: data['subJob'] ?? '',
          position: data['position'] ?? '',
          wage: data['wage'] ?? '',
          isSelected: data['isSelected'] ?? false,
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<JobPost>> getJobPostByUserId(String userId) async {
    try {
      final value = await usersCollection.doc(userId).get();
      final data = value.data() as Map<String, dynamic>;
      final jobPosts = data['jobPostSelected'] as Map<String, dynamic>;
      return jobPosts.values
          .map((e) => JobPost(
                id: e['id'] ?? '',
                description1: e['description1'] ?? '',
                description2: e['description2'] ?? '',
                subJob: e['subJob'] ?? '',
                position: e['position'] ?? '',
                wage: e['wage'] ?? '',
                isSelected: e['isSelected'] ?? false,
              ))
          .toList();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<JobPost>> selectedPost(JobPost jobPost, String? userId) async {
    try {
      final Map<String, dynamic> jobPosts = {};

      // get job post selection from the database field with userId
      final DocumentSnapshot snapshot = await usersCollection.doc(userId).get();

      final value = snapshot.data() as Map<String, dynamic>;

      jobPosts.addAll(value['jobPostSelected'] as Map<String, dynamic>);

      // if the job post is already selected, remove it from the jobPosts
      if (jobPosts.containsKey(jobPost.id)) {
        jobPosts.remove(jobPost.id);
      } else {
        // if the job post is not selected, add it to the jobPosts
        jobPosts[jobPost.id] = jobPost.toJson();
      }

      // update the jobPostSelected field in the database
      await usersCollection.doc(userId).update({'jobPostSelected': jobPosts});

      return jobPosts.values
          .map((e) => JobPost(
                id: e['id'] ?? '',
                description1: e['description1'] ?? '',
                description2: e['description2'] ?? '',
                subJob: e['subJob'] ?? '',
                position: e['position'] ?? '',
                wage: e['wage'] ?? '',
                isSelected: e['isSelected'] ?? false,
              ))
          .toList();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
