import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geatx_student_management/db/model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../core/color/colors.dart';
import '../db/db_helper.dart';

class DetailsControllerGet extends GetxController {
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var phoneController = TextEditingController();
  Rx<File?> selectedImage = Rx<File?>(null);
  Rx<String> selectedGender = Rx<String>('O');
  RxBool isEditing = false.obs;
  final StudentsModel studentDetails;

  DetailsControllerGet(this.studentDetails);

  @override
  void onInit() {
   super.onInit();
   setInitialValues();
  }

  void enableEditing(){
    isEditing.value = true;
  }

  Future<void> pickImageFromGallery() async{
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      selectedImage.value = File(pickedImage.path);
    }
  }

  void setGender(String gender){
    selectedGender.value = gender;
  }
  

  void setInitialValues(){
    nameController.text = studentDetails.name;
    ageController.text = studentDetails.age;
    phoneController.text = studentDetails.phoneno;
    selectedGender.value = studentDetails.gender;
    if (studentDetails.imageurl != null && studentDetails.imageurl!.isNotEmpty) {
      selectedImage.value = File(studentDetails.imageurl!);
    }
  }

  Future<void> updateStudentDetails(StudentsModel studentDetails)async{
    final updatedStudent = StudentsModel(
      id: studentDetails.id,
      name: nameController.text, 
      gender: selectedGender.value, 
      phoneno: phoneController.text, 
      age: ageController.text,
      imageurl: selectedImage.value?.path ?? studentDetails.imageurl
      );

      try {
         await Get.find<Studentdatabase>().updateStudent(updatedStudent);
         isEditing.value = false;
         Get.back(result: true);
        Get.snackbar(
       'Update Successful',
       'Successfully Updated datas',
        margin: EdgeInsets.all(10),
        borderRadius: 10,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor:green,
        colorText: white,
        icon: Icon(Icons.cloud_upload, color: white),
      );
      } catch (e) {
        log('Updation faild: $e');
        Get.snackbar(
       'Update Error',
       'Failed due to file Updation !',
        margin: EdgeInsets.all(10),
        borderRadius: 10,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor:red,
        colorText: white,
        icon: Icon(Icons.thumb_down, color: white),
      );
      }
  }
  

  Future<void> deleteStudent(int studentId) async{
    try {
      await  Get.find<Studentdatabase>().deleteStudent(studentId);
      Get.back(result: true);
        Get.snackbar(
       'Delet Successful',
       'Successfully Deleted !',
        margin: EdgeInsets.all(10),
        borderRadius: 10,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor:green,
        colorText: white,
        icon: Icon(Icons.thumb_up, color: white),
      );
    } catch (e) {
      log('Deletion Failed $e');
          Get.snackbar(
       'Delet Failed',
       'Failed due to file deletion !',
        margin: EdgeInsets.all(10),
        borderRadius: 10,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor:red,
        colorText: white,
        icon: Icon(Icons.thumb_down, color: white),
      );
    }
  }

}