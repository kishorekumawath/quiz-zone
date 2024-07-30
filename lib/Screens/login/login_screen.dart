import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quiz_zone/config/theme/app_colors.dart';
import 'package:quiz_zone/controllers/auth_controller.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  static const String routeName = "/login";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          gradient: mainGradient()
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center ,
          children: [
            Image.asset('assets/images/app_splash_logo.png',width: 200,height: 200,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text("This is Study app you can use it. u have full access to access latest question and quiz paper to improve your knownleage in your domain specific",style: TextStyle(color: onSurfaceTextColor,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            ),
            GestureDetector(
              onTap: (){
                controller.signInWithGoogle();
              },
              child: Container(
                padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                  ),
                  child: SvgPicture.asset("assets/icons/google.svg")),
            ),


          ],
        ),
      ),
    );
  }
}
