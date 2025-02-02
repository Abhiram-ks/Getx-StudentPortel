import 'package:flutter/material.dart';
import 'package:geatx_student_management/home/homepage/widget/custom_listdatas.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../core/color/colors.dart';
import '../../core/constant.dart';
import '../../db/db_helper.dart';
import '../../db/model.dart';
import '../add_student/add_student.dart';
import '../spec/detailpage.dart';
import '../widget/appbar.dart';
import 'widget/search_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Studentdatabase studentController = Get.put(Studentdatabase());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = Get.height;
    double screenWidth = Get.width;

    return Scaffold(
      appBar: CustomAppbar(title: 'Students Management'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Searchbarmain(
                hintText: 'Search for Student',
                onSearchPressed: (searchTerm) {
                  studentController.fetchStudents(searchTerm);
                }),
            hight10,
            Expanded(child: Obx(() {
              if (studentController.studentsList.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/purchase_empty.json',
                        width: screenWidth * 0.5,
                        height: screenHeight * 0.3,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        'No records found!',
                        style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 129, 129, 129),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 10,),
                 itemCount: studentController.studentsList.length,
                itemBuilder: (context, index) {
                  final student = studentController.studentsList[index];
                  return ShowSaleAdded(
                    onTap: () async{
                      var result = await Get.to(() => Detailpage(studentDetails: StudentsModel(
                        id:student['id'],
                        imageurl: student['imageurl'],
                        name: student['name'],
                        gender: student['gender'],
                        phoneno: student['phoneno'].toString(),
                        age:  student['age'].toString(),
                        )));
                        if (result == true) {
                          studentController.fetchStudents();
                        }
                    },
                    name: student['name'],
                     age:  student['age'].toString(),
                     imagePath: student['imageurl'],
                     phone: student['phoneno'].toString(),
                      gender: student['gender'],
                      );
                }
                ,);
            }))
          ],
        ),
      ),
       floatingActionButton: FloatingActionButton(
        onPressed: () async{
         var result = await Get.to(() => AddStudents());
          if (result == true) {
            studentController.fetchStudents();
          }   
        },
        backgroundColor: black,
        child: const Icon(
          Icons.person_add,
          color: white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}