import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_management/models/data_models.dart';
import 'package:school_management/provider/db_functions.dart';
// import 'package:student_management/db/db_functions.dart';
// import 'package:student_management/model/data_model.dart';

class ScreenAdd extends StatefulWidget {
  ScreenAdd({Key? key}) : super(key: key);

  @override
  State<ScreenAdd> createState() => _ScreenAddState();
}

class _ScreenAddState extends State<ScreenAdd> {
  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _phoneNumberController = TextEditingController();

  final _placeController = TextEditingController();

  // int? idnum;

  File? imagefile;

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(shrinkWrap: true, children: [
            Form(
                key: _formkey,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10, top: 20),
                      child: Text(
                        'ADD STUDENT',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                      child: ClipOval(child: imageprofile(context)),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 219, 219, 219),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              controller: _nameController,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Enter Student Name',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              controller: _ageController,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Enter Age',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              controller: _phoneNumberController,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Enter the Number',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              controller: _placeController,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Enter Place',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Processing Data'),
                            ),
                          );
                        }
                        onAddStudentButtonClicked();
                      },
                      child: const Text('Add Student'),
                    )
                  ],
                ))
          ]),
        ),
      ),
    );
  }

  Future<void> takePhoto() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;

    File imageTemprary = File(image.path);
    setState(() {
      imagefile = imageTemprary;
    });
    imageadd(image);
  }

  Future<void> takecamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image == null) return;

    final imageTemprary = File(image.path);
    setState(() {
      imagefile = imageTemprary;
    });
    imageadd(image);
  }

  Future<void> showBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (ctx1) {
        return Container(
          height: 100,
          width: double.infinity,
          color: Colors.white,
          child: Column(children: [
            const Text('choise your profile photo'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      takecamera();
                    },
                    icon: const Icon(Icons.camera)),
                IconButton(
                    onPressed: () {
                      takePhoto();
                    },
                    icon: const Icon(Icons.browse_gallery))
              ],
            )
          ]),
        );
      },
    );
  }

  Widget imageprofile(BuildContext context) {
    return Stack(
      children: [
        imagefile != null
            ? Image.file(
                imagefile!,
                width: 250,
                height: 250,
                fit: BoxFit.cover,
              )
            : Image.network(
                'https://cdn3d.iconscout.com/3d/premium/thumb/young-bussinesman-avatar-5460205-4544331.png',
                width: 250,
                height: 250,
                fit: BoxFit.contain,
              ),
        Positioned(
          left: 50,
          right: 50,
          top: 170,
          bottom: 0,
          // padding: const EdgeInsets.only(top: 150, left: 150),
          child: IconButton(
              onPressed: () {
                showBottomSheet(context);
              },
              icon: const Icon(
                Icons.camera_alt,
                color: Colors.black,
                size: 40,
              )),
        )
      ],
    );
  }

  Future<void> onAddStudentButtonClicked() async {
    final name = _nameController.text;
    final age = _ageController.text;
    final phoneNumber = _phoneNumberController.text;
    final place = _placeController.text;
    if (name.isEmpty || age.isEmpty || phoneNumber.isEmpty || place.isEmpty) {
      return;
    } else {
      final _student = StudentModel(
        name: name,
        age: age,
        phoneNumber: phoneNumber,
        place: place,
        imgstri: imgstring,
      );

      addStudent(_student);
      imgstring = '';
      Navigator.of(context).pop();
    }
  }
}
