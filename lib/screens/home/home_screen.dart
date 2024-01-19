import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:instax/blocs/post_bloc/post_bloc.dart';
import 'package:instax/blocs/post_bloc/post_event.dart';
import 'package:instax/blocs/post_bloc/post_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          if (state.status == PostStatus.success) {
            // print('Loading posts ${state.posts}');
          } else if (state.status == PostStatus.failure) {
            // log('Failed to load posts: ${state.posts}');
          }
        },
        builder: (context, state) {
          if (state.status == PostStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == PostStatus.success) {
            final localPosts = state.posts;
            return ListView.builder(
              itemCount: localPosts.length,
              itemBuilder: (context, index) {
                final post = localPosts[index];
                return ListTile(
                  title: Text(post.post),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<PostBloc>().add(DeletePost(post: post));
                    },
                  ),
                );
              },
            );
          } else if (state.status == PostStatus.failure) {
            return Text('Error: ${state.posts}');
          } else {
            return const Text('No data');
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // sign out from the app
      //     context.read<SignInBloc>().add(SignOutRequired());
      //   },
      //   child: const Icon(Icons.logout_outlined),
      // ),
    );
  }
}
