import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_repository/job_repository.dart';
import 'package:job_repository/src/models/job.dart';
import 'job_repo.dart';

class FirebaseJobRepository implements JobRepository {
  final jobCollection = FirebaseFirestore.instance.collection('jobs');
  final subJobCollection = FirebaseFirestore.instance.collection('subJobs');

  @override
  Future<List<Job>> getJob() {
    try {
      jobCollection.get().then((value) => value.docs
          .map((e) => Job.fromEntity(JobEntity.fromDocument(e.data())))
          .toList());
      return jobCollection.get().then((value) => value.docs
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
      return subJobCollection.where('jobParentId', whereIn: jobIds).get().then(
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
