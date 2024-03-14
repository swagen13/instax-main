import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_repository/job_repository.dart';
import 'package:job_repository/src/models/job.dart'; // Importing the Job model

class FirebaseJobRepository implements JobRepository {
  final skillsCollection = FirebaseFirestore.instance.collection('skills');
  final subskillsCollection =
      FirebaseFirestore.instance.collection('skillChildrens');

  @override
  Future<List<Job>> getJob() async {
    try {
      final value = await skillsCollection.get();
      print('value.docs : ${value.docs.length}');
      return value.docs
          .map((e) => Job.fromDocument(e))
          .toList(); // Using Job model directly
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Job>> getSubjobByJobIds(List<String> jobIds) async {
    try {
      final value =
          await subskillsCollection.where('parentId', whereIn: jobIds).get();
      return value.docs
          .map((e) => Job.fromDocument(e))
          .toList(); // Using Job model directly
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
