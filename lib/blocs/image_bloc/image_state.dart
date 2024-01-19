import 'dart:io';

import 'package:equatable/equatable.dart';

enum ImageStatus { initial, success, loading, failure }

class ImageSelectionState extends Equatable {
  final ImageStatus status;
  final String imageUrl;
  final File? selectedImage;

  // Define a constant instance of Image
  static String _emptyImageUrl = '';

  ImageSelectionState({
    this.status = ImageStatus.initial,
    String? imageUrl,
    this.selectedImage,
  }) : imageUrl = imageUrl ?? _emptyImageUrl;

  ImageSelectionState copyWith({
    ImageStatus? status,
    String? imageUrl,
    File? selectedImage,
  }) {
    return ImageSelectionState(
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
      selectedImage: selectedImage ?? this.selectedImage,
    );
  }

  @override
  List<Object> get props => [status, imageUrl];
}
