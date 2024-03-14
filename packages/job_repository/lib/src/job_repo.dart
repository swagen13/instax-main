import 'models/models.dart';

abstract class JobRepository {
  Future<List<Job>> getJob();

  Future<List<Job>> getSubjobByJobIds(List<String> jobIds);
}
