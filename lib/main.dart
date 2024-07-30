import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:quiz_zone/Screens/Introduction/introductions_screen.dart';
import 'package:quiz_zone/Screens/Splash/splash_screen.dart';
import 'package:quiz_zone/bindings/initial_bindings.dart';
import 'package:quiz_zone/config/theme/app_light_theme.dart';
import 'package:quiz_zone/controllers/theme_controller.dart';
import 'package:quiz_zone/data_uploader_screen.dart';
import 'package:quiz_zone/firebase_options.dart';
import 'package:quiz_zone/routes/app_routes.dart';

import 'config/theme/app_dark_theme.dart';

Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  InitialBindings().dependencies();
  runApp(const MyApp());
}
//
// class MyApp2 extends StatelessWidget {
//   const MyApp2({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       home: DataUploaderScreen(),
//     );
//
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Get.find<ThemeController>().lightTheme,
      getPages: AppRoutes.routes(),
    );
  }
}

