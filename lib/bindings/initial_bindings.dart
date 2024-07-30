import 'package:get/get.dart';
import 'package:quiz_zone/controllers/auth_controller.dart';
import 'package:quiz_zone/controllers/theme_controller.dart';
import 'package:quiz_zone/services/firebase_storage_services.dart';

class InitialBindings implements Bindings{
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(AuthController(),permanent: true);
  }
}