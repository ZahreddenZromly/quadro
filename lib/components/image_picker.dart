import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickers extends StatefulWidget {
  const ImagePickers({super.key});

  @override
  State<ImagePickers> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePickers> {
  File? _image;
  Future getImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Stack(children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.teal,
                    radius: 80,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? const Icon(
                            Icons.person,
                            size: 80,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ],
              ),
              Positioned(
                left: 110,
                top: 100,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                    border: Border.all(
                      color: Colors
                          .white, // Choose the color of the circular border
                      width: 2.0,
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: getImage,
                    color: Colors.white,
                    style: const ButtonStyle(),
                  ),
                ),
              ),
            ]),
          ]),
        ]),
      ],
    );
  }
}
