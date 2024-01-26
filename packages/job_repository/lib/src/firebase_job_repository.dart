import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_repository/job_repository.dart';
import 'package:job_repository/src/models/job.dart';
import 'job_repo.dart';

class FirebaseJobRepository implements JobRepository {
  final skillsCollection = FirebaseFirestore.instance.collection('skills');
  final subskillsCollection =
      FirebaseFirestore.instance.collection('skillChildrens');

  @override
  Future<List<Job>> getJob() {
    try {
      return skillsCollection.get().then((value) => value.docs
          .map((e) => Job.fromEntity(JobEntity.fromDocument(e.data())))
          .toList());
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<SubJob>> getSubjobByJobIds(List<String> jobIds) {
    try {
      // loop for each jobIds
      subskillsCollection
          .where('parentId', whereIn: jobIds)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          print('element.data() : ${element.data()}');
        });
      });
      return subskillsCollection.where('parentId', whereIn: jobIds).get().then(
          (value) => value.docs
              .map(
                  (e) => SubJob.fromEntity(SubJobEntity.fromDocument(e.data())))
              .toList());
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
