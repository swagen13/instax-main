// post_bloc.dart
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:instax/blocs/post_bloc/post_event.dart';
import 'package:instax/blocs/post_bloc/post_state.dart';
import 'package:post_repository/post_repository.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;
  List<Post> localPosts = []; // Local list to manage posts

  PostBloc({required this.postRepository}) : super(PostState()) {
    on<FetchPosts>((event, emit) async {
      log('FetchPosts event triggered');
      try {
        localPosts =
            await postRepository.getPost(); // Update the localPosts field
        emit(state.copyWith(
            status: PostStatus.success, posts: List.of(localPosts)));
      } catch (e) {
        emit(state.copyWith(status: PostStatus.failure));
      }
    });

    on<AddPost>((event, emit) async {
      try {
        final newPost = await postRepository.createPost(event.post);
        log('New post created: $newPost');
        localPosts.add(newPost);
        print('Updated localPosts: $localPosts');
        emit(state.copyWith(
            status: PostStatus.success, posts: List.of(localPosts)));
      } catch (e) {
        log('Failed to create post: $e');
        emit(state.copyWith(status: PostStatus.failure));
      }
    });

    on<DeletePost>((event, emit) async {
      try {
        await postRepository.deletePost(event.post);
        // Assuming there's a method like deletePost in your repository
        log('Post deleted: ${event.post}');
        localPosts.removeWhere((post) =>
            post.postId == event.post.postId); // Remove from local list
        emit(state.copyWith(
            status: PostStatus.success, posts: List.of(localPosts)));
      } catch (e) {
        emit(state.copyWith(status: PostStatus.failure));
      }
    });
  }
  List<Post> getLocalPosts() {
    print('Local posts: $localPosts');
    return List.of(localPosts);
  }
}
