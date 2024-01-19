import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class ImageSelectionEvent extends Equatable {}

class ImageSelectedEvent extends ImageSelectionEvent {
  final File selectedImage;

  ImageSelectedEvent({required this.selectedImage});

  @override
  List<Object> get props => [selectedImage];
}
