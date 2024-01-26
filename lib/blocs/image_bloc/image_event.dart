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
  final String uid;

  UploadImageEvent({required this.selectedImage, required this.uid});

  @override
  List<Object> get props => [selectedImage];
}
