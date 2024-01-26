class SubJobEntity {
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
  List<Map<String, String>> translations;

  SubJobEntity({
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

  Map<String, Object?> toDocument() {
    return {
      'color': color,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'description': description,
      'icon': icon,
      'id': id,
      'name': name,
      'parentId': parentId,
      'sequence': sequence,
      'slug': slug,
      'translations': translations,
    };
  }

  static SubJobEntity fromDocument(Map<String, dynamic> doc) {
    return SubJobEntity(
      color: doc['color'] as String?,
      createdAt: doc['createdAt'] as String,
      updatedAt: doc['updatedAt'] as String,
      description: doc['description'] as String?,
      icon: doc['icon'] as String?,
      id: doc['id'] as String,
      name: doc['name'] as String,
      parentId: doc['parentId'] as String,
      sequence: doc['sequence'] as int,
      slug: doc['slug'] as String,
      translations: _parseTranslations(doc['translations']),
    );
  }

  List<Object?> get props => [
        color,
        createdAt,
        updatedAt,
        description,
        icon,
        id,
        name,
        parentId,
        sequence,
        slug,
        translations,
      ];

  @override
  String toString() {
    return '''SubJobEntity: {
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

  static fromEntity(SubJobEntity fromDocument) {}
}

class JobEntity {
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
  List<Map<String, String>> translations;

  JobEntity({
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

  Map<String, Object?> toDocument() {
    return {
      'color': color,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'description': description,
      'icon': icon,
      'id': id,
      'name': name,
      'parentId': parentId,
      'sequence': sequence,
      'slug': slug,
      'translations': translations,
    };
  }

  static JobEntity fromDocument(Map<String, dynamic> doc) {
    return JobEntity(
      color: doc['color'] as String?,
      createdAt: doc['createdAt'] as String,
      updatedAt: doc['updatedAt'] as String,
      description: doc['description'] as String?,
      icon: doc['icon'] as String?,
      id: doc['id'] as String,
      name: doc['name'] as String,
      parentId: doc['parentId'] as String,
      sequence: doc['sequence'] as int,
      slug: doc['slug'] as String,
      translations: _parseTranslations(doc['translations']),
    );
  }

  List<Object?> get props => [
        color,
        createdAt,
        updatedAt,
        description,
        icon,
        id,
        name,
        parentId,
        sequence,
        slug,
        translations,
      ];

  @override
  String toString() {
    return '''JobEntity: {
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

List<Map<String, String>> _parseTranslations(dynamic translations) {
  if (translations is List<dynamic>) {
    return translations
        .whereType<Map<String, String>>() // Filter only Map<String, String>
        .toList();
  }
  // Handle the case where translations is not a List<dynamic>
  return [];
}
