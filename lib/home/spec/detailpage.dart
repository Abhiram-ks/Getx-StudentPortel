
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../core/color/colors.dart';
import '../../core/constant.dart';
import '../../db/model.dart';
import '../../getX/details_controller_get.dart';
import '../add_student/widget/custom_text.dart';
import '../add_student/widget/gender_selection.dart';
import '../add_student/widget/submit_button.dart';
import '../add_student/widget/validation.dart';
import '../homepage/widget/bottomsheet_custom.dart';
import '../widget/appbar.dart';


class Detailpage extends StatelessWidget {
  final StudentsModel studentDetails;
  const Detailpage({
    super.key,
    required this.studentDetails,
  });

  @override
  Widget build(BuildContext context) {
    final DetailsControllerGet controller = Get.put(DetailsControllerGet(studentDetails));


    return Scaffold(
      appBar: CustomAppbar(title: controller.isEditing.value ? 'Updated' : 'Specification'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Form(
          child: Obx(() {
            return ListView(
              children: [
                hight30,
                Center(
                  child: GestureDetector(
                    onTap: controller.isEditing.value ? controller.pickImageFromGallery : null,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.height * 0.15,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 236, 236, 236),
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: controller.selectedImage.value != null
                            ? Image.file(
                                controller.selectedImage.value!,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.height * 0.15,
                                height: MediaQuery.of(context).size.height * 0.15,
                              )
                            : Lottie.asset(
                                'assets/addimage.json',
                                fit: BoxFit.contain,
                                width: MediaQuery.of(context).size.height * 0.25,
                                height: MediaQuery.of(context).size.height * 0.25,
                              ),
                      ),
                    ),
                  ),
                ),
                hight10,
                CustomTextFormFild(
                  icon: Icons.person,
                  labelText: 'Name',
                  hintText: studentDetails.name,
                  controller: controller.nameController,
                  validate: NameValidator.validate,
                  enabled: controller.isEditing.value,
                ),
                PhoneNumberFiled(
                  icon: Icons.cake_sharp,
                  labelText: 'Age',
                  hintText: studentDetails.age,
                  controller: controller.ageController,
                  validate: AgeValidator.validate,
                  enable: controller.isEditing.value,
                ),
                PhoneNumberFiled(
                  icon: Icons.phone,
                  labelText: 'Phone Number',
                  hintText: studentDetails.phoneno,
                  controller: controller.phoneController,
                  validate: PhoneNumberValidator.validate,
                  enable: controller.isEditing.value,
                ),
                hight10,
                Text('     Select Gender'),
                GenderSelection(
                  selectedGender: controller.selectedGender.value,
                  onChanged: controller.isEditing.value
                      ? (value) {
                          controller.setGender(value!);
                        }
                      : (value){},
                ),
                Lottie.asset(
                  'assets/loading.json',
                  fit: BoxFit.contain,
                  width: MediaQuery.of(context).size.height * 0.20,
                  height: MediaQuery.of(context).size.height * 0.20,
                ),
                ActionButtons(
                  onCancelPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) {
                        return CustomeBottmSheet(
                          onConfirm: () async {
                            await controller.deleteStudent(studentDetails.id!);
                            Get.back();
                          },
                          color: red,
                          icon: Icons.delete_sweep_outlined,
                          title: 'Delete Student Details',
                          description: 'After confirming, the data will be permanently deleted from the database.',
                        );
                      },
                    );
                  },
                  onSubmitPressed: () {
                    if (!controller.isEditing.value) {
                      controller.enableEditing();
                    } else {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) {
                          return CustomeBottmSheet(
                            onConfirm: () async {
                              await controller.updateStudentDetails(studentDetails);
                            },
                            icon: Icons.update,
                            color: Colors.blue,
                            title: 'Update Student Details',
                            description: 'After confirming, the current student details will be updated in the database.',
                          );
                        },
                      );
                    }
                  },
                  cancelText: 'Delete',
                  submitText: controller.isEditing.value ? 'Update' : 'Edit',
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
