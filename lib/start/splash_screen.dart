import 'package:flutter/material.dart';
import 'package:geatx_student_management/getX/splash_controller_get.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/color/colors.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SplashControllerGet controller = Get.put(SplashControllerGet());

    return Scaffold(
     body:  Center(
      child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,

         children: [
           AnimatedBuilder(
            animation: controller.colorAnimation, 
            builder: (context, child) {
              return ShaderMask(
                    shaderCallback: (bounds) {
                    return LinearGradient(
                      colors: [blue,white, black],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [
                        controller.colorAnimation.value,
                        (controller.colorAnimation.value + 0.0).clamp(0.0, 2.0),
                        (controller.colorAnimation.value + 0.2).clamp(0.0, 1.0),
                      ],
                    ).createShader(bounds);
                  },
                  child: Text(
                      'STUDENT\nMANAGEMENT',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  );
            },
            ),
            const SizedBox(height: 40),
            const Text('Student Management Database'),
            const Text('Loading...'),
         ],
      ),
     ),
    );
  }
}