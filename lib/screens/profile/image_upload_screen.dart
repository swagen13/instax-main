import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instax/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:instax/blocs/image_bloc/image_bloc.dart';
import 'package:instax/blocs/image_bloc/image_event.dart';
import 'package:instax/blocs/image_bloc/image_state.dart';

// ignore: must_be_immutable
class ImageUploadScreen extends StatelessWidget {
  ImageUploadScreen({Key? key}) : super(key: key);
  File? _selectedImage;

  Future<void> _openGallery(BuildContext context) async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      _selectedImage = File(image.path);
      // ignore: use_build_context_synchronously
      context.read<ImageSelectionBloc>().add(
            ImageSelectedEvent(
              selectedImage: _selectedImage!,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ImageSelectionBloc, ImageSelectionState>(
        listener: (context, imageState) {
          if (imageState.status == ImageStatus.success) {
            Navigator.pushNamed(context, 'workType');
          }
        },
        builder: (context, imageState) {
          print('state.selectedImage ${imageState.selectedImage}');
          return Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    "รูปโปรไฟล์ของคุณ",
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.displaySmall?.fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      Center(
                        child: Container(
                          width: 250,
                          height: 300,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.outline,
                              width: 1,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: _selectedImage != null
                                ? Image.file(
                                    _selectedImage!,
                                    fit: BoxFit.cover,
                                  )
                                : Column(
                                    children: [
                                      const SizedBox(
                                        height: 80,
                                      ),
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            _openGallery(context);
                                          },
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 105,
                                      ),
                                      FilledButton(
                                        style: ButtonStyle(
                                          minimumSize:
                                              MaterialStateProperty.all<Size>(
                                                  const Size(225, 40)),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/workType');
                                        },
                                        child: Text(
                                          'อัพโหลดรูป',
                                          style: TextStyle(
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.fontSize,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      if (imageState.selectedImage != null)
                        Positioned(
                          child: Stack(
                            children: [
                              // Container for the image
                              Center(
                                child: Container(
                                  width: 250,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image:
                                          FileImage(imageState.selectedImage!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              // Container with a gradient for the overlay
                              Center(
                                child: Container(
                                  width: 250,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(
                                            0.7), // Set the opacity here
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // ElevatedButton
                              Positioned(
                                bottom: 5, // Adjust the bottom value as needed
                                right: 65, // Adjust the right value as needed
                                left: 65,
                                child: OutlinedButton(
                                  onPressed: () {
                                    _openGallery(context);
                                  },
                                  style: ButtonStyle(
                                    side: MaterialStateProperty.all(
                                      const BorderSide(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'เปลี่ยนรูป',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.fontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'โปรดเลือกรูปที่',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize:
                            Theme.of(context).textTheme.bodyLarge?.fontSize,
                        fontFamily: 'NotoSansThai',
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'แสดงความเป็นตัวตน',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 86, 210, 1),
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .fontSize,
                          ),
                        ),
                        TextSpan(
                          text:
                              'ของคุณ\nมากที่สุดเพื่อให้ผู้คนรู้จักขึ้นมากขึ้น!',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  imageState.selectedImage != null
                      ? BlocBuilder<AuthenticationBloc, AuthenticationState>(
                          builder: (context, myUserState) {
                            return FilledButton(
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all<Size>(
                                    const Size(225, 40)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, 'workType');
                                // // upload image to firebase storage
                                context.read<ImageSelectionBloc>().add(
                                      UploadImageEvent(
                                        selectedImage:
                                            imageState.selectedImage!,
                                        uid: myUserState.user!.uid,
                                      ),
                                    );
                              },
                              child: imageState.status == ImageStatus.loading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      'ยืนยัน',
                                      style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.fontSize,
                                      ),
                                    ),
                            );
                          },
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
