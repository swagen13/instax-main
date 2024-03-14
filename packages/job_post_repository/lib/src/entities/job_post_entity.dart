class JobPostEntity {
  String id;
  String description1;
  String description2;
  String subJob;
  String position;
  String wage;
  bool isSelected;

  JobPostEntity({
    required this.id,
    required this.description1,
    required this.description2,
    required this.subJob,
    required this.position,
    required this.wage,
    this.isSelected = false,
  });

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'description1': description1,
      'description2': description2,
      'subJob': subJob,
      'position': position,
      'wage': wage,
      'isSelected': isSelected,
    };
  }

  static JobPostEntity fromDocument(Map<String, dynamic> doc) {
    return JobPostEntity(
      id: doc['id'] as String,
      description1: doc['description1'] as String,
      description2: doc['description2'] as String,
      subJob: doc['subJob'] as String,
      position: doc['position'] as String,
      wage: doc['wage'] as String,
      isSelected: doc['isSelected'] as bool,
    );
  }

  List<Object?> get props =>
      [id, description1, description2, subJob, position, wage, isSelected];

  @override
  String toString() {
    return '''JobPostEntity: {
      id: $id
      description1: $description1
      description2: $description2
      subJob: $subJob
      position: $position
      wage: $wage
      isSelected: $isSelected
    }''';
  }
}
