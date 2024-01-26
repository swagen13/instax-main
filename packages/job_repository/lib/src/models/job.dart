import '../entities/entities.dart';

class SubJob {
  String? color;
  String createdAt;
  String updatedAt;
  String? description;
  String? icon;
  String id;
  String name;
  String parentId;
  int sequence;
  String slug;
  List<Map<String, String>> translations; // List to hold translation maps

  SubJob({
    this.color,
    required this.createdAt,
    required this.updatedAt,
    this.description,
    this.icon,
    required this.id,
    required this.name,
    required this.parentId,
    required this.sequence,
    required this.slug,
    required this.translations,
  });

  SubJobEntity toEntity() {
    return SubJobEntity(
      color: color,
      createdAt: createdAt,
      updatedAt: updatedAt,
      description: description,
      icon: icon,
      id: id,
      name: name,
      parentId: parentId,
      sequence: sequence,
      slug: slug,
      translations: translations,
    );
  }

  static SubJob fromEntity(SubJobEntity entity) {
    return SubJob(
      color: entity.color,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      description: entity.description,
      icon: entity.icon,
      id: entity.id,
      name: entity.name,
      parentId: entity.parentId,
      sequence: entity.sequence,
      slug: entity.slug,
      translations: entity.translations,
    );
  }

  @override
  String toString() {
    return '''SubJob: {
      color: $color
      createdAt: $createdAt
      updatedAt: $updatedAt
      description: $description
      icon: $icon
      id: $id
      name: $name
      parentId: $parentId
      sequence: $sequence
      slug: $slug
      translations: $translations
    }''';
  }
}

class Job {
  String? color;
  String createdAt;
  String updatedAt;
  String? description;
  String? icon;
  String id;
  String name;
  String parentId;
  int sequence;
  String slug;
  List<Map<String, String>> translations; // List to hold translation maps

  Job({
    this.color,
    required this.createdAt,
    required this.updatedAt,
    this.description,
    this.icon,
    required this.id,
    required this.name,
    required this.parentId,
    required this.sequence,
    required this.slug,
    required this.translations,
  });

  JobEntity toEntity() {
    return JobEntity(
      color: color,
      createdAt: createdAt,
      updatedAt: updatedAt,
      description: description,
      icon: icon,
      id: id,
      name: name,
      parentId: parentId,
      sequence: sequence,
      slug: slug,
      translations: translations,
    );
  }

  static Job fromEntity(JobEntity entity) {
    return Job(
      color: entity.color,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      description: entity.description,
      icon: entity.icon,
      id: entity.id,
      name: entity.name,
      parentId: entity.parentId,
      sequence: entity.sequence,
      slug: entity.slug,
      translations: entity.translations,
    );
  }

  @override
  String toString() {
    return '''Job: {
      color: $color
      createdAt: $createdAt
      updatedAt: $updatedAt
      description: $description
      icon: $icon
      id: $id
      name: $name
      parentId: $parentId
      sequence: $sequence
      slug: $slug
      translations: $translations
    }''';
  }
}
