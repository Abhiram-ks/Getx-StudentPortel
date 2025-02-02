import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geatx_student_management/db/model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../core/color/colors.dart';
import '../db/db_helper.dart';

class StudentController extends GetxController {
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var phonenoController = TextEditingController();
  var selectedImage = Rx<File?>(null);
  var selectedGender = "G".obs;

  Future<void> pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      selectedImage.value = File(pickedImage.path);
    }
  }

  Future<void> addStudentDetails() async {
    if (nameController.text.isEmpty ||
        phonenoController.text.isEmpty ||
        ageController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all fields',
        margin: EdgeInsets.all(10),
        borderRadius: 10,
        duration: Duration(seconds: 2),
        backgroundColor:red,
        colorText: white,
        snackPosition: SnackPosition.BOTTOM,
        icon: Icon(Icons.warning, color:white),
      );
      return;
    }

    final student  = StudentsModel(
      name: nameController.text, 
      gender: selectedGender.value,
      phoneno: phonenoController.text,
      age: ageController.text,
      imageurl: selectedImage.value?.path
      );

      await Get.find<Studentdatabase>().addStudent(student);

     Get.snackbar(
        'Success',
        'Successfully add datas',
        margin: EdgeInsets.all(10),
        borderRadius: 10,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor:green,
        colorText: white,
        icon: Icon(Icons.thumb_up, color: white),
      );

      nameController.clear();
      phonenoController.clear();
      ageController.clear();
      selectedGender.value = 'G';
      selectedImage.value = null;
  }
}
