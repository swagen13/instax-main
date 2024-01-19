import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/image_bloc/image_event.dart';
import 'package:instax/blocs/image_bloc/image_state.dart';
import 'package:flutter/material.dart';

class ImageSelectionBloc
    extends Bloc<ImageSelectionEvent, ImageSelectionState> {
  ImageSelectionBloc() : super(ImageSelectionState(selectedImage: null)) {
    on<ImageSelectedEvent>(
      (event, emit) => emit(
        ImageSelectionState(selectedImage: event.selectedImage),
      ),
    );
  }
}
