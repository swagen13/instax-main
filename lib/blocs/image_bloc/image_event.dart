import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class ImageSelectionEvent extends Equatable {}

class ImageSelectedEvent extends ImageSelectionEvent {
  final File selectedImage;

  ImageSelectedEvent({required this.selectedImage});

  @override
  List<Object> get props => [selectedImage];
}

class UploadImageEvent extends ImageSelectionEvent {
  final File selectedImage;
  final String? uid;

  UploadImageEvent({required this.selectedImage, required this.uid});

  @override
  List<Object> get props => [selectedImage];
}

class ImageSelectedInChat extends ImageSelectionEvent {
  final File selectedImage;

  ImageSelectedInChat({required this.selectedImage});

  @override
  List<Object> get props => [selectedImage];
}

class RemoveImageInChat extends ImageSelectionEvent {
  final File selectedImage;

  RemoveImageInChat({required this.selectedImage});

  @override
  List<Object> get props => [selectedImage];
}

class UploadImageInChat extends ImageSelectionEvent {
  final File selectedImage;
  final String chatId;

  UploadImageInChat({required this.selectedImage, required this.chatId});

  @override
  List<Object> get props => [selectedImage, chatId];
}
