// post_event.dart
import 'package:equatable/equatable.dart';
import 'package:post_repository/post_repository.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class FetchPosts extends PostEvent {}

class AddPost extends PostEvent {
  final Post post;

  AddPost({required this.post});

  @override
  List<Object> get props => [post];
}

class DeletePost extends PostEvent {
  final Post post;

  DeletePost({required this.post});

  @override
  List<Object> get props => [post];
}
