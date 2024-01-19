import '../entities/entities.dart';

class SubJob {
  final String subJobId;
  final String subJobName;
  final String jobParentId;

  SubJob({
    required this.subJobId,
    required this.subJobName,
    required this.jobParentId,
  });

  SubJobEntity toEntity() {
    return SubJobEntity(
      subJobId: subJobId,
      subJobName: subJobName,
      jobParentId: jobParentId,
    );
  }

  static SubJob fromEntity(SubJobEntity entity) {
    return SubJob(
      subJobId: entity.subJobId,
      subJobName: entity.subJobName,
      jobParentId: entity.jobParentId,
    );
  }

  @override
  String toString() {
    return '''SubJob: {
      subJobId: $subJobId,
      subJobName: $subJobName,
      jobParentId: $jobParentId
    }''';
  }
}

class Job {
  final String jobId;
  final String jobName;
  final String imageUrl;
  final List<Job> selectedJobs;

  Job({
    required this.jobId,
    required this.jobName,
    required this.imageUrl,
    this.selectedJobs = const [],
  });

  JobEntity toEntity() {
    return JobEntity(
      jobId: jobId,
      jobName: jobName,
      imageUrl: imageUrl,
    );
  }

  static Job fromEntity(JobEntity entity) {
    return Job(
      jobId: entity.jobId,
      jobName: entity.jobName,
      imageUrl: entity.imageUrl,
    );
  }

  @override
  String toString() {
    return '''Job: {
      jobId: $jobId,
      jobName: $jobName,
      imageUrl: $imageUrl
    }''';
  }
}
