import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
              selectedImage: File(image.path),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ImageSelectionBloc, ImageSelectionState>(
        builder: (context, state) {
          print('state.selectedImage ${state.selectedImage}');
          return Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  const Text(
                    "รูปโปรไฟล์ของคุณ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
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
                            color: const Color.fromRGBO(244, 249, 255, 1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color.fromRGBO(217, 218, 222, 1),
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
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(4, 94, 228, 1),
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 3,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            _openGallery(context);
                                          },
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 60,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 100,
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  const Color.fromRGBO(
                                                      255, 222, 168, 1)),
                                          minimumSize:
                                              MaterialStateProperty.all<Size>(
                                                  const Size(225, 35)),
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
                                        child: const Text(
                                          'อัพโหลดรูป',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      if (state.selectedImage != null)
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
                                      image: FileImage(state.selectedImage!),
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
                                child: ElevatedButton(
                                  onPressed: () {
                                    _openGallery(context);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      const Color.fromARGB(0, 34, 82,
                                          255), // Set the opacity here
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        side: const BorderSide(
                                          color: Colors
                                              .white, // Set the border color here
                                          width: 1.0, // Set the border width
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'เปลี่ยนรูป',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
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
                    text: const TextSpan(
                      text: 'โปรดเลือกรูปที่',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'NotoSansThai',
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'แสดงความเป็นตัวตน',
                          style: TextStyle(
                            color: Color.fromARGB(255, 34, 82, 255),
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text:
                              'ของคุณ\nมากที่สุดเพื่อให้ผู้คนรู้จักขึ้นมากขึ้น!',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
