import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:school_management/models/data_models.dart';
import 'package:school_management/provider/db_functions.dart';
import 'package:school_management/ui/add_student_screen/screen_add_student.dart';
import 'package:school_management/ui/search_screen/screen_search.dart';
import 'package:school_management/ui/student_details_screen/student_details_screen.dart';
// import 'package:student_management/db/db_functions.dart';
// import 'package:student_management/model/data_model.dart';
// import 'package:student_management/screens/add_student_screen.dart';
// import 'package:student_management/screens/screen_student_details.dart';
// import 'package:student_management/screens/search_screen.dart';

ValueNotifier<List<StudentModel>> temp = ValueNotifier([]);

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getallStudents();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => ScreenSearch()));
              },
              color: Colors.white,
              icon: const Icon(Icons.search))
        ],
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: studentlistNotifier,
          builder: (BuildContext ctx, List<StudentModel> studentList,
              Widget? child) {
            return ListView.separated(
                itemBuilder: (ctx, index) {
                  final data = studentList[index];
                  print(data.imgstri);
                  return ListTile(
                    title: Text(data.name),
                    subtitle: Text(data.age),
                    leading: CircleAvatar(
                      radius: 40,
                      child: imgstring.trim().isEmpty
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: MemoryImage(
                                Base64Decoder()
                                    .convert(studentList[index].imgstri),
                              ),
                            )
                          : Container(
                              color: Colors.white,
                            ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        if (data.id != null) {
                          deleteStudent(data.id!);
                        } else {
                          //print('halo');
                        }
                      },
                      icon: const Icon(Icons.delete),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => ScreenStudentDetails(
                                studentmodel: studentList[index],
                              )));
                    },
                  );
                },
                separatorBuilder: (ctx, index) {
                  return const Divider();
                },
                itemCount: studentList.length);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        child: const Text('ADD'),
        backgroundColor: Colors.black87,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) {
              return ScreenAdd();
            }),
          );
        },
      ),
    );
  }
}
