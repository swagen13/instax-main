import 'package:cloud_firestore/cloud_firestore.dart';

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
  List<Map<String, dynamic>> translations; // List to hold translation maps

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

  // Factory method to create a Job instance from a DocumentSnapshot
  factory Job.fromDocument(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return Job(
      color: data['color'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
      description: data['description'],
      icon: data['icon'],
      id: data['id'],
      name: data['name'],
      parentId: data['parentId'],
      sequence: data['sequence'],
      slug: data['slug'],
      translations: List<Map<String, dynamic>>.from(data['translations'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
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
}
