import 'package:equatable/equatable.dart';
import 'package:post_repository/post_repository.dart';

enum PostStatus { initial, success, failure, loading }

class PostState extends Equatable {
  final PostStatus status;
  final List<Post> posts;

  const PostState({
    this.status = PostStatus.initial,
    this.posts = const <Post>[],
  });

  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
    List<Post>? localPosts, // Include localPosts in copyWith
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
    );
  }

  @override
  List<Object> get props => [status, posts]; // Include localPosts in props
}
