import 'package:flutter/material.dart';
import 'package:post_repository/post_repository.dart';

class PostUpdateScreen extends StatefulWidget {
  final Post post;

  const PostUpdateScreen({required this.post, Key? key}) : super(key: key);

  @override
  State<PostUpdateScreen> createState() => _PostUpdateScreenState();
}

class _PostUpdateScreenState extends State<PostUpdateScreen> {
  late String hintText;

  @override
  void initState() {
    super.initState();
    // Initialize hintText with the initial post text
    hintText = widget.post.post;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
