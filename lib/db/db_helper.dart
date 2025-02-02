import 'dart:developer';
import 'package:geatx_student_management/db/model.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';


class Studentdatabase extends GetxController {
  late Database _db;
  var studentsList  = <Map<String, dynamic>>[].obs;
  

  @override
  void onInit(){
    super.onInit();
    initializeDatabase();
  }

  Future<void> initializeDatabase() async {
  _db = await openDatabase(
    "student.db",
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE student (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, gender TEXT, phoneno TEXT, age TEXT, imageurl TEXT);");
    },

  );
  fetchStudents();
}


Future<void> addStudent(StudentsModel value) async {
  try {
    await _db.rawInsert(
        "INSERT INTO student (id,name, gender, phoneno, age, imageurl) VALUES (?, ?, ?, ?, ?, ?)",
        [value.id, value.name, value.gender, value.phoneno, value.age, value.imageurl]);
        fetchStudents();
       log("Student add Successfully");
       Get.back(result: true);
  } catch (e) {
    log("Error adding Student: $e");
  }
}



Future<void> updateStudent(StudentsModel updateStudent) async {
  await _db.update(
    'student',
    {
      'name': updateStudent.name,
      'gender': updateStudent.gender,
      'phoneno': updateStudent.phoneno,
      'age': updateStudent.age,
      'imageurl': updateStudent.imageurl
    },
    where: 'id = ?',
    whereArgs: [updateStudent.id],
  );
  fetchStudents();
  Get.back(result:  true);
}





Future<void> deleteStudent(int id) async {
  await _db.rawDelete('DELETE FROM student WHERE id = ?', [id]);
  fetchStudents();
    Get.back(result:  true);
}

  Future<void> fetchStudents([String searchTerm = ""]) async { 
    final students = await _db.rawQuery("SELECT * FROM student");

    final filteredStudents = students.where((student){
      return student['name']
      .toString()
      .toLowerCase()
      .contains(searchTerm.toLowerCase());
    }).toList();

    studentsList.assignAll(filteredStudents);
  }
}

