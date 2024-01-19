class SubJobEntity {
  String subJobId;
  String subJobName;
  String jobParentId;

  SubJobEntity({
    required this.subJobId,
    required this.subJobName,
    required this.jobParentId,
  });

  Map<String, Object?> toDocument() {
    return {
      'subJobId': subJobId,
      'subJobName': subJobName,
      'jobParentId': jobParentId,
    };
  }

  static SubJobEntity fromDocument(Map<String, dynamic> doc) {
    return SubJobEntity(
      subJobId: doc['subJobId'] as String,
      subJobName: doc['subJobName'] as String,
      jobParentId: doc['jobParentId'] as String,
    );
  }

  List<Object?> get props => [subJobId, subJobName, jobParentId];

  @override
  String toString() {
    return '''SubJobEntity: {
      subJobId: $subJobId
      subJobName: $subJobName
      jobParentId: $jobParentId
    }''';
  }

  static fromEntity(SubJobEntity fromDocument) {}
}

class JobEntity {
  String jobId;
  String jobName;
  String imageUrl;

  JobEntity({
    required this.jobId,
    required this.jobName,
    required this.imageUrl,
  });

  Map<String, Object?> toDocument() {
    return {
      'jobId': jobId,
      'jobName': jobName,
      'imageUrl': imageUrl,
    };
  }

  static JobEntity fromDocument(Map<String, dynamic> doc) {
    return JobEntity(
      jobId: doc['jobId'] as String,
      jobName: doc['jobName'] as String,
      imageUrl: doc['imageUrl'] as String,
    );
  }

  List<Object?> get props => [jobId, jobName, imageUrl];

  @override
  String toString() {
    return '''JobEntity: {
      jobId: $jobId
      jobName: $jobName
      imageUrl: $imageUrl
    }''';
  }
}
