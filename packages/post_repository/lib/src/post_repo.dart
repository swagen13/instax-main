import 'models/models.dart';

abstract class PostRepository {
  Future<Post> createPost(Post post);

  Future<Post> updatePost(Post post);

  Future<List<Post>> getPost();

  Future<Post> getPostById(String postId);

  Future<void> deletePost(Post post);
}
