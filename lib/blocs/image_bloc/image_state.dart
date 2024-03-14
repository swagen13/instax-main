import 'dart:io';

import 'package:equatable/equatable.dart';

enum ImageStatus { initial, success, loading, failure }

class ImageSelectionState extends Equatable {
  final ImageStatus status;
  final String imageUrl;
  final File? selectedImage;
  final List<File> selectedImageInChat;

  // Define a constant instance of Image
  static const String _emptyImageUrl = '';

  const ImageSelectionState({
    this.status = ImageStatus.initial,
    String? imageUrl,
    this.selectedImage,
    this.selectedImageInChat = const [],
  }) : imageUrl = imageUrl ?? _emptyImageUrl;

  ImageSelectionState copyWith({
    ImageStatus? status,
    String? imageUrl,
    File? selectedImage,
    List<File>? selectedImageInChat,
  }) {
    return ImageSelectionState(
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
      selectedImage: selectedImage ?? this.selectedImage,
      selectedImageInChat: selectedImageInChat ?? this.selectedImageInChat,
    );
  }

  @override
  List<Object?> get props =>
      [status, imageUrl, selectedImage, selectedImageInChat];
}
