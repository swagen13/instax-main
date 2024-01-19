import 'models/models.dart';

abstract class JobRepository {
  Future<List<Job>> getJob();

  Future<List<SubJob>> getSubjobByJobIds(List<String> jobIds);
}
