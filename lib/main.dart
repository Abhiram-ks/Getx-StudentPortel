import 'package:flutter/material.dart';
import 'package:geatx_student_management/db/db_helper.dart';
import 'package:geatx_student_management/start/splash_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/color/colors.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(Studentdatabase());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
     title: 'STUDENT DATABASE',
     debugShowCheckedModeBanner: false,
     theme: ThemeData(
      primarySwatch: primaryColor,
      scaffoldBackgroundColor: white,
      appBarTheme: AppBarTheme(
        color: white,
      ),
      fontFamily: GoogleFonts.montserrat().fontFamily,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: black),
        bodyMedium: TextStyle(color: black),
        bodySmall: TextStyle(color: black)
      )
     ),
     home: SplashScreen(),
    );
  }
}