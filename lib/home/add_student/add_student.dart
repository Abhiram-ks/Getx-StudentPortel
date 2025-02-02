import 'package:flutter/material.dart';
import 'package:geatx_student_management/home/add_student/widget/custom_text.dart';
import 'package:geatx_student_management/home/add_student/widget/gender_selection.dart';
import 'package:geatx_student_management/home/add_student/widget/submit_button.dart';
import 'package:geatx_student_management/home/add_student/widget/validation.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../core/constant.dart';
import '../../getX/student_formcontroller.dart';
import '../widget/appbar.dart';


class AddStudents extends StatelessWidget {
  final StudentController studentController = Get.put(StudentController());
   AddStudents({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = Get.height;

    return Scaffold(
       appBar: CustomAppbar(title: 'Student Information'),
      body:  Padding(padding:  const EdgeInsets.symmetric(horizontal: 14.0),
      child: Form(
        key: GlobalKey<FormState>(),
        child: ListView(
          children: [
            hight30,
            Center(
              child: GestureDetector(
                onTap: studentController.pickImageFromGallery,
                child: Obx(() => ClipOval(
                  child: Container(
                    height: screenHeight * 0.15,
                    width: screenHeight * 0.15,
                   alignment: Alignment.center,
                   decoration:  BoxDecoration(
                      color: Color.fromARGB(255, 236, 236, 236),
                      shape: BoxShape.circle,
                  ),
                  child: studentController.selectedImage.value != null 
                  ? ClipOval(
                              child: Image.file(
                               studentController.selectedImage.value!,
                              fit: BoxFit.cover,
                               width: screenHeight * 0.15,
                            height: screenHeight * 0.15,
                           ),
        ) : Lottie.asset( 'assets/addimage.json',fit: BoxFit.contain,
                              width: screenHeight * 0.25, height: screenHeight * 0.25,)
                  )
                )),
              ),
            ),
            hight10,
            CustomTextFormFild(
              labelText:'Name',
              hintText:'Enter student name',
              icon: Icons.person,
              controller: studentController.nameController,
              validate: NameValidator.validate,
              ),
              PhoneNumberFiled(
                icon: Icons.cake,
                labelText: 'Age',
                hintText: 'Enter student age', 
                controller: studentController.ageController,
                validate: AgeValidator.validate),
                PhoneNumberFiled(
                icon: Icons.phone,
                labelText: 'Phone Number',
                hintText: 'Enter Phone Number',
                controller: studentController.phonenoController,
                validate: PhoneNumberValidator.validate,
              ), hight10,
              Text('     Select Gender'),
              Obx(() => GenderSelection(
                  selectedGender: studentController.selectedGender.value,
                  onChanged: (value) => studentController.selectedGender.value = value!,
               ),),
              SizedBox(
                height: 130,
              ),
           ActionButtons(
            onCancelPressed: ()=>Get.back(result:  true), 
            onSubmitPressed: studentController.addStudentDetails,
            cancelText: 'Cancel',
           submitText: 'Submit',
            )
          ],
        )),
      ),
    );
  }
}