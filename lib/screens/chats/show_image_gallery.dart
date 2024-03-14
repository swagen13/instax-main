import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/chats_bloc/chats_bloc.dart';
import 'package:instax/blocs/chats_bloc/chats_state.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ShowImageGalleryScreen extends StatelessWidget {
  final String imageSelected;
  const ShowImageGalleryScreen({Key? key, required this.imageSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Images'),
      ),
      body: BlocBuilder<ChatsBloc, ChatsState>(
        builder: (context, chatsState) {
          // Find the index of the selected image in the imageList
          final selectedIndex = chatsState.imageList.indexWhere(
            (imageUrl) => imageUrl == imageSelected,
          );

          return PhotoViewGallery.builder(
            itemCount: chatsState.imageList.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(
                  chatsState.imageList[index]!,
                ),
              );
            },
            // Use PageController to set the initial page to the index of the selected image
            pageController: PageController(initialPage: selectedIndex),
          );
        },
      ),
    );
  }
}
