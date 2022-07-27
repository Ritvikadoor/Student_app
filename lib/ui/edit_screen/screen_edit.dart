import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:school_management/models/data_models.dart';
import 'package:school_management/provider/db_functions.dart';
// import 'package:student_management/db/db_functions.dart';
// import 'package:student_management/model/data_model.dart';

class ScreenEdit extends StatelessWidget {
  final StudentModel studentmdoel;

  ScreenEdit({Key? key, required this.studentmdoel}) : super(key: key);

  final nameUpdateController = TextEditingController();
  final ageUpdateController = TextEditingController();
  final phoneUpdateController = TextEditingController();
  final placeUpdateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameUpdateController.text = studentmdoel.name;
    ageUpdateController.text = studentmdoel.age;
    phoneUpdateController.text = studentmdoel.phoneNumber;
    placeUpdateController.text = studentmdoel.place;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Center(
                child: Text(
              'EDIT',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            )),
            CircleAvatar(
              radius: 40,
              child: imgstring.trim().isEmpty
                  ? CircleAvatar(
                      radius: 50,
                      backgroundImage: MemoryImage(
                        const Base64Decoder().convert(studentmdoel.imgstri),
                      ),
                    )
                  : Container(
                      color: Colors.white,
                    ),
            ),
            const SizedBox(
              height: 60,
            ),
            TextFormField(
              // initialValue: '$namee',
              controller: nameUpdateController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              // initialValue: '$agee',
              controller: ageUpdateController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              // initialValue: '$phonee',
              controller: phoneUpdateController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              // initialValue: '$placee',
              controller: placeUpdateController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  updateStudent();
                },
                child: const Text('Update'))
          ],
        ),
      )),
    );
  }

  Future<void> updateStudent() async {
    final nAme = nameUpdateController.text;
    final aGe = ageUpdateController.text;
    final pHone = phoneUpdateController.text;
    final pLace = placeUpdateController.text;

    if (nAme.isEmpty || aGe.isEmpty || pHone.isEmpty || pLace.isEmpty) {
      return;
    } else {
      final studentup = StudentModel(
          name: nAme,
          age: aGe,
          phoneNumber: pHone,
          place: pLace,
          imgstri: imgstring.isEmpty ? studentmdoel.imgstri : imgstring,
          id: studentmdoel.id);
      print(studentup.id);
      if (studentup.id != null) {
        await studentupdate(studentup.id!, studentup);
      }
    }
  }
}
