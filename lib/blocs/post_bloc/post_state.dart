import 'package:equatable/equatable.dart';
import 'package:job_repository/job_repository.dart';
import 'package:post_repository/post_repository.dart';

enum PostStatus { initial, success, failure, loading }

class PostState extends Equatable {
  final PostStatus status;
  final List<Post> posts;
  final List<Job> selectSubJobs; // Include localPosts in state

  const PostState({
    this.status = PostStatus.initial,
    this.posts = const <Post>[],
    this.selectSubJobs = const <Job>[],
  });

  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
    List<Post>? localPosts, // Include localPosts in copyWith
    List<Job>? selectSubJobs,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      selectSubJobs:
          selectSubJobs ?? this.selectSubJobs, // Include localPosts in copyWith
    );
  }

  @override
  List<Object> get props =>
      [status, posts, selectSubJobs]; // Include localPosts in props
}
