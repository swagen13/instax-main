import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/image_bloc/image_event.dart';
import 'package:instax/blocs/image_bloc/image_state.dart';
import 'package:user_repository/user_repository.dart';

class ImageSelectionBloc
    extends Bloc<ImageSelectionEvent, ImageSelectionState> {
  final UserRepository _userRepository;

  ImageSelectionBloc(this._userRepository)
      : super(ImageSelectionState(selectedImage: null)) {
    on<ImageSelectedEvent>((event, emit) async {
      emit(
        ImageSelectionState(
          selectedImage: event.selectedImage,
          status: ImageStatus.initial,
        ),
      );
    });

    on<UploadImageEvent>((event, emit) async {
      emit(
        ImageSelectionState(
          status: ImageStatus.loading,
        ),
      );
      try {
        await _userRepository.uploadPicture(event.selectedImage, event.uid);

        emit(
          ImageSelectionState(
            selectedImage: event.selectedImage,
            status: ImageStatus.success,
          ),
        );
      } catch (e) {
        emit(
          ImageSelectionState(
            selectedImage: event.selectedImage,
            imageUrl: null,
          ),
        );
      }
    });

    on<ImageSelectedInChat>((event, emit) async {
      print('ImageSelectedInChat');
      log('ImageSelectedInChat: ${state.selectedImageInChat.length}');

      emit(
        ImageSelectionState(
          selectedImageInChat: [
            ...state.selectedImageInChat,
            event.selectedImage,
          ],
        ),
      );
      log('ImageSelectedInChat: ${state.selectedImageInChat.length}');
    });

    on<RemoveImageInChat>((event, emit) async {
      emit(
        ImageSelectionState(
          selectedImageInChat: [
            ...state.selectedImageInChat
                .where((element) => element != event.selectedImage),
          ],
        ),
      );
    });
  }
}
