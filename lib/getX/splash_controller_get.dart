import 'package:flutter/material.dart';
import 'package:geatx_student_management/home/homepage/home_screen.dart';
import 'package:get/get.dart';

// ignore: deprecated_member_use
class SplashControllerGet extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController animationController;
  late Animation<double> colorAnimation;

  @override
  void onInit(){
    super.onInit();
    animationController = AnimationController(vsync: this,
    duration: const Duration(seconds: 4),
    );
    
    colorAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.linear),
    );

    animationController.repeat(reverse: true);

    Future.delayed(const Duration(seconds: 3), (){
     Get.off(() => HomeScreen());
    });
  }
  
  
  void  onclose(){
    animationController.dispose();
    super.onClose();
  }
}