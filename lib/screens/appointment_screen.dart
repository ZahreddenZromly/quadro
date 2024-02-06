import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

enum towingType { Tug, Pull }

class RequestAppointmentScreen extends StatefulWidget {
  const RequestAppointmentScreen({super.key});

  @override
  State<RequestAppointmentScreen> createState() =>
      _RequestAppointmentScreenState();
}

class _RequestAppointmentScreenState extends State<RequestAppointmentScreen> {
  // final ChipThemeData customTheme = ChipThemeData.fromDefaults(
  //   shape: RoundedRectangleBorder(side: BorderSide.none),
  // );
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

  List<String> brands = ['Toyota', 'Hyundai'];
  late String selectedBrand;
  final int _selectedType = -1;

  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedBrand = brands[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 350,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Request an\nAppointment',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            const SizedBox(
              width: 350,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Car Model',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 0.5,
                          color:
                              Colors.black), // Adjust width and color as needed
                    ),
                  ),
                  height: 60,
                  width: 150,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: Colors.grey[100],
                      icon: const Icon(Icons.expand_more),
                      isExpanded: true,
                      value: selectedBrand, // Initially selected option
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedBrand = newValue!;
                        });
                      },

                      style: const TextStyle(fontSize: 22, color: Colors.black),
                      iconSize: 35,
                      items:
                          brands.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(child: Text(value)),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(width: 32),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 0.5,
                          color:
                              Colors.black), // Adjust width and color as needed
                    ),
                  ),
                  height: 60,
                  width: 150,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: Colors.grey[100],
                      icon: const Icon(Icons.expand_more),
                      // hint: Text('brand'),
                      isExpanded: true,
                      // itemHeight: 80,
                      value: selectedBrand, // Initially selected option
                      onChanged: (String? newValue) {
                        // Handle dropdown selection here
                        setState(() {
                          selectedBrand = newValue!;
                        });
                      },

                      style: const TextStyle(fontSize: 22, color: Colors.black),
                      iconSize: 35,
                      items:
                          brands.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(child: Text(value)),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const SizedBox(
              width: 350,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Descreption',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 350,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black26),
                  hintText: 'Descreption about your car.',
                  border: InputBorder.none,
                ),
                controller: descriptionController,
                maxLength: 1000,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                maxLines: null, // Allow for indefinite number of lines
              ),
            ),

            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => getImage(),
                  child: Container(
                    width: 350,
                    // height: 50,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black38),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Upload Car Images',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Icon(Icons.add_a_photo_outlined),
                          ],
                        ),
                        if (_image != null)
                          Row(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                margin: const EdgeInsets.only(top: 12),
                                decoration: const BoxDecoration(
                                  // borderRadius: BorderRadius.circular(0),
                                  color: Colors.teal,
                                ),
                                child: ClipRRect(
                                  // borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    _image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // if (_image != null) Image.file(_image!),

            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => WorkshopScreen(),
                //   ),
                // );
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(4)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                minimumSize: MaterialStateProperty.all(const Size(362, 60.0)),
                // iconColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(Colors.teal),
              ),
              child: const Text(
                'Send Request',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
