import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/image_bloc/image_bloc.dart';
import 'package:instax/blocs/image_bloc/image_state.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ShowImageScreen extends StatelessWidget {
  const ShowImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Images'),
      ),
      body: BlocBuilder<ImageSelectionBloc, ImageSelectionState>(
        builder: (context, imageState) {
          return PhotoViewGallery.builder(
            itemCount: imageState.selectedImageInChat.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: FileImage(
                  imageState.selectedImageInChat[index],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
