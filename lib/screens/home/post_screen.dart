import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/post_bloc/post_bloc.dart';
import 'package:instax/blocs/post_bloc/post_event.dart';
import 'package:instax/blocs/post_bloc/post_state.dart';
import 'package:post_repository/post_repository.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
      listener: (context, state) {
        if (state.status == PostStatus.success) {
          // print state information
          print('Loaded posts: ${state.posts}');
          Navigator.pop(context);
        } else if (state.status == PostStatus.failure) {
          // Do something when an error occurs
        }
      },
      builder: (context, state) {
        print('Current state: ${state.posts}');
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Assuming you have a Post model with a field called post
              final post = Post(
                // random id from dates
                postId: DateTime.now().millisecondsSinceEpoch.toString(),
                post: 'New post content',
                createAt: DateTime.now(),
                updateAt: DateTime.now(),
              );
              // AddPost event is handled in PostBloc
              context.read<PostBloc>().add(AddPost(post: post));
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
