import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfileImage extends StatelessWidget {
  String title;
  ProfileImage({super.key, required this.title});




  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const ImagePickers(),
          const SizedBox(height: 20,),



        ],
      ),
    );
  }
}

class ImagePickers extends StatefulWidget {

  const ImagePickers({super.key});

  @override
  State<ImagePickers> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePickers> {
  File? _image;
  Future getImage() async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
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

        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                        children:[ Row(
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
                            left:110 ,
                            top: 100,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                                border: Border.all(
                                  color: Colors.white, // Choose the color of the circular border
                                  width: 2.0,
                                ),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: getImage,
                                color: Colors.white,
                                style: const ButtonStyle(

                                ),
                              ),
                            ),
                          ),
                        ]
                    ),
                  ]
              ),
            ]
        ),
      ],

    );
  }
}