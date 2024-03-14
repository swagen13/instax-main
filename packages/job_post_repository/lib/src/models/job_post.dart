class JobPost {
  String id;
  String description1;
  String description2;
  String subJob;
  String position;
  String wage;
  bool isSelected;

  JobPost({
    required this.id,
    required this.description1,
    required this.description2,
    required this.subJob,
    required this.position,
    required this.wage,
    this.isSelected = false,
  });

  Map<String, dynamic> toJson() {
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

  @override
  String toString() {
    return '''Job: {
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
