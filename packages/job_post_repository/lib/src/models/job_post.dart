import 'package:job_post_repository/src/entities/entities.dart';

class JobPost {
  String id;
  String description1;
  String description2;
  String subJob;
  String position;
  String wage;

  JobPost({
    required this.id,
    required this.description1,
    required this.description2,
    required this.subJob,
    required this.position,
    required this.wage,
  });

  JobPostEntity toEntity() {
    return JobPostEntity(
      id: id,
      description1: description1,
      description2: description2,
      subJob: subJob,
      position: position,
      wage: wage,
    );
  }

  static JobPost fromEntity(JobPostEntity entity) {
    return JobPost(
      id: entity.id,
      description1: entity.description1,
      description2: entity.description2,
      subJob: entity.subJob,
      position: entity.position,
      wage: entity.wage,
    );
  }

  @override
  String toString() {
    return '''Job: {
      id: $id
      description1: $description1
      description2: $description2
      subJob: $subJob
      position: $position
      wage: $wage
    }''';
  }
}
