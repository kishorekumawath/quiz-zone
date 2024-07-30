import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:quiz_zone/controllers/auth_controller.dart';
import 'package:quiz_zone/firebase_ref/References.dart';
import 'package:url_launcher/url_launcher.dart';
enum DrawerStatus{drawerOpened,drawerClosed}
class MyZoomDrawerController extends GetxController{
  final zoomDrawerController = ZoomDrawerController();
  final Rx<String> userProfileUrl = "".obs;
  Rxn<User?> user = Rxn();
  @override
  void onReady() {
    user.value = Get.find<AuthController>().getUser();
    getProfilePic();
    super.onReady();
  }
  void toggleDrawer(){
    zoomDrawerController.toggle?.call();
    update();
  }

  void getProfilePic()async{
    try{
      final DocumentSnapshot<Map<String,dynamic>> userInfo =await userRf.doc(Get.find<AuthController>().userMail).get();
      if(userInfo.exists){
        Map<String,dynamic> data = userInfo.data()!;
        userProfileUrl.value = data['profilepic'];
      }

      print("--------------->${userProfileUrl.value}");
    }catch(e){
      print("-----> error at zoom_drawer controller $e");
    }
  }
  void signIn(){

  }

  void signOut(){
    Get.find<AuthController>().signOut();
  }

  void website(){

  }

  void email(){
    final Uri emailLaunchUri = Uri(
      scheme: "mailto",
      path:" kishorekumawath6@gamil.com"
    );
    _launch(emailLaunchUri.toString());
  }

  Future<void> _launch(String url) async{
     if(!await launch(url)){
       throw "Could not launch $url";
     }
  }
}