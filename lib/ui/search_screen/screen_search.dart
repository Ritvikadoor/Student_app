import 'package:flutter/material.dart';
import 'package:school_management/models/data_models.dart';
import 'package:school_management/provider/db_functions.dart';
import 'package:school_management/ui/student_details_screen/student_details_screen.dart';
// import 'package:student_management/db/db_functions.dart';
// import 'package:student_management/model/data_model.dart';

// import 'package:student_management/screens/screen_student_details.dart';

ValueNotifier<List<StudentModel>> temp = ValueNotifier([]);

class ScreenSearch extends StatelessWidget {
  ScreenSearch({Key? key}) : super(key: key);

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            onTap: () {},
            onChanged: (String? value) {
              if (value == null || value.isEmpty) {
                temp.value.addAll(studentlistNotifier.value);
                temp.notifyListeners();
              } else {
                temp.value.clear();
                for (StudentModel i in studentlistNotifier.value) {
                  if (i.name.toLowerCase().contains(value.toLowerCase())) {
                    temp.value.add(i);
                  }
                  temp.notifyListeners();
                }
              }
            },
            controller: searchController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.all(15),
              hintText: 'Search',
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: temp,
        builder:
            (BuildContext ctx, List<StudentModel> searchdata, Widget? child) {
          return ListView.separated(
              itemBuilder: (ctx, index) {
                final data = searchdata[index];
                return ListTile(
                  title: Text(data.name),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => ScreenStudentDetails(
                          studentmodel: data,
                        ),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (ctx, index) {
                return const Divider();
              },
              itemCount: searchdata.length);
        },
      )),
    );
  }
}
