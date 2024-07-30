import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_zone/widgets/app_circle_btn.dart';

import '../../config/theme/app_colors.dart';
import '../../services/firebase_storage_services.dart';

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: mainGradient(),
        ),
        padding: EdgeInsets.symmetric(horizontal: Get.width*0.2),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star_rate_rounded,size: 65,),
            SizedBox(height: 20,),
            const Text(
                "This is study app. you can use it as you want if you understand how it works you would scale it.with this you will master firebase backend and flutter frontend.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: onSurfaceTextColor,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 20,),
            AppCircleBtn(onTap: (){
            Get.put(FirebaseStorageServices());
            Get.offAllNamed("/home");
        },child: Icon(Icons.arrow_forward_rounded,size: 30,),),
          ],
        ),
      ),
    );
  }
}
