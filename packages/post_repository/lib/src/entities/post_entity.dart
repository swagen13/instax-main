import 'package:cloud_firestore/cloud_firestore.dart';

class PostEntity {
  String postId;
  String post;
  DateTime createAt;
  DateTime updateAt;

  PostEntity({
    required this.postId,
    required this.post,
    required this.createAt,
    required this.updateAt,
  });

  Map<String, Object?> toDocument() {
    return {
      'postId': postId,
      'post': post,
      'createAt': createAt,
      'updateAt': updateAt,
    };
  }

  static PostEntity fromDocument(Map<String, dynamic> doc) {
    return PostEntity(
      postId: doc['postId'] as String,
      post: doc['post'] as String,
      createAt: (doc['createAt'] as Timestamp).toDate(),
      updateAt: (doc['updateAt'] as Timestamp).toDate(),
    );
  }

  List<Object?> get props => [postId, post, createAt];

  @override
  String toString() {
    return '''PostEntity: {
      postId: $postId
      post: $post
      createAt: $createAt
      updateAt: $updateAt
    }''';
  }
}
