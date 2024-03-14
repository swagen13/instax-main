import 'package:flutter/material.dart';

class PostDetial extends StatelessWidget {
  final String postId;

  const PostDetial({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extract arguments
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    // Access postId from arguments
    final postId = arguments?['postId'];

    // Use postId in the page
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Detail'),
      ),
      body: Center(
        child: Text('Post ID: $postId'),
      ),
    );
  }
}
