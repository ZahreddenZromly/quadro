import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quadro/components/image_picker.dart';
import 'package:quadro/my_flutter_app_icons.dart';

enum towingType { Tug, Pull }

class TowingScreen extends StatefulWidget {
  TowingScreen({super.key});

  @override
  State<TowingScreen> createState() => _TowingScreenState();
}

class _TowingScreenState extends State<TowingScreen> {
  final db = FirebaseFirestore.instance;
  List<String> brands = [];

  Future<void> getCarBrands() async {
    try {
      final brandsSnapshot = await db.collection('Car Brands').get();
      brands = brandsSnapshot.docs.map((doc) => doc['name'] as String).toList();
      setState(() {});
    } catch (error) {
      // Handle errors gracefully (e.g., display an error message)
    }
    print('$brands[0]');
  }

  List<String> models = [];

  Future<void> getCarModels(String selectedBrand) async {
    try {
      final modelsSnapshot = await db
          .collection('Car Brands')
          .doc(selectedBrand)
          .collection('models')
          .get();
      models = modelsSnapshot.docs.map((doc) => doc['name'] as String).toList();
      selectedModel = models[0];
      setState(() {});
    } catch (error) {
      // Handle errors gracefully
    }
    // print('models: $selectedBrand $models');
  }

  String? selectedBrand;
  String? selectedModel;
  int _selectedType = -1;
  Future<void> _fetchData() async {
    try {
      await getCarBrands();
      selectedBrand = brands[0]; // Set initial brand after fetching
      await getCarModels(selectedBrand!);
    } catch (error) {
      // Handle errors gracefully
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  final TextEditingController descriptionController = TextEditingController();
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
    // if (brands.isEmpty) {
    //   return Center(child: CircularProgressIndicator()); // Show loading
    // }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 350,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Request a\nTowing',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            const SizedBox(
              width: 350,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Towing Type',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
            InnerShadow(
              shadows: [
                Shadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 1,
                    offset: const Offset(3, 2))
              ],
              child: Container(
                margin: EdgeInsets.only(top: 8),
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                      2,
                      (int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: const BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(69, 0, 0, 0),
                                  offset: Offset(2, 3),
                                  spreadRadius: 1,
                                  blurRadius: 7)
                            ]),
                            child: ChoiceChip(
                              labelPadding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 8),

                              backgroundColor: Colors.grey[100],
                              showCheckmark: false,
                              padding: EdgeInsets.all(8),
                              label: Row(
                                children: [
                                  Icon(
                                    Icons.car_crash,
                                    size: 30,
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    '${towingType.values[index].name}',
                                    style: TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 22,
                                      color: _selectedType == index
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              // color of selected chip

                              // selected chip value
                              selected: _selectedType == index,
                              selectedColor: Colors.teal,

                              // onselected method
                              onSelected: (bool selected) {
                                setState(() {
                                  _selectedType = selected ? index : -1;
                                  print(_selectedType == index);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
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
                      onChanged: (newBrand) => setState(() {
                        selectedBrand = newBrand!;
                        getCarModels(newBrand);
                        // selectedModel = null; // Reset selected model
                      }),

                      style: TextStyle(fontSize: 22, color: Colors.black),
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
                      icon: Icon(Icons.expand_more),
                      // hint: Text('brand'),
                      isExpanded: true,
                      // itemHeight: 80,
                      value: selectedModel, // Initially selected option
                      onChanged: (newModel) => setState(() {
                        selectedModel = newModel!;
                      }),

                      style: TextStyle(fontSize: 22, color: Colors.black),
                      iconSize: 35,
                      items:
                          models.map<DropdownMenuItem<String>>((String value) {
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
            const SizedBox(height: 20),
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
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
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
                maxLength: 350,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                maxLines: null, // Allow for indefinite number of lines
              ),
            ),

            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => getImage(),
                  child: Container(
                    width: 350,
                    // height: 50,
                    padding: EdgeInsets.all(12),
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
                                margin: EdgeInsets.only(top: 12),
                                decoration: BoxDecoration(
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
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 350,
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black38),
                    borderRadius: BorderRadius.circular(8)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Select Your Location',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Icon(Icons.location_on_outlined),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),
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
                'Submit',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
