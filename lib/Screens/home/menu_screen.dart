import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quiz_zone/config/theme/app_colors.dart';
import 'package:quiz_zone/config/theme/custom_text_styles.dart';
import 'package:quiz_zone/controllers/auth_controller.dart';
import 'package:quiz_zone/controllers/zoom_drawer_controller.dart';

class MyMenuScreen extends GetView<MyZoomDrawerController> {
  const MyMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 10,left: 20),
          child: Obx(()=>controller.user.value ==null
              // user not logged in
              ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Spacer(flex: 1,),
              GestureDetector(
                onTap: (){
                  Get.find<AuthController>().signInWithGoogle();
                  // controller.signInWithGoogle();
                },
                child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset("assets/icons/google.svg"),
                        Text("signIn with google",style: detailText.copyWith(fontWeight: FontWeight.w900,fontSize: 14),),
                      ],
                    )),
              ),
            ],
          ):

              // user logged in
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Padding(
                    padding: EdgeInsets.symmetric(horizontal:Get.width*0.08),
                    child: CircleAvatar(
                      radius: Get.height*0.1,
                      child: ClipOval(
                        child: Image.network(
                          controller.userProfileUrl.value,
                          width: 100.0,
                          height: 100.0,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, widget, event) {
                            if (event == null) {
                              return widget;
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                          errorBuilder: (context, error, stackTrace) {
                            // If there is an error loading the network image (e.g., URL is null),
                            // display a fallback assets image.
                            return Image.asset(
                              'assets/images/app_splash_logo.png', // Replace with your assets image path
                              width: 100.0,
                              height: 100.0,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                  ),),
                  Transform.translate(
                    offset: Offset(0,-20),
                      child: Center(child: Text(controller.user.value!.displayName??'',style: const TextStyle(fontWeight: FontWeight.w900,fontSize: 18,color: onSurfaceTextColor),))),
                  const Spacer(flex: 1,),
                  _DrawerBtn(icon: Icons.web, label: "Website",onTap: ()=>controller.website(),),
                  _DrawerBtn(icon: Icons.facebook_rounded, label: "Facebook",onTap: ()=>controller.website(),),
                  _DrawerBtn(icon: Icons.email_rounded, label: "Email",onTap: ()=>controller.website(),),
                  _DrawerBtn(icon: Icons.logout_rounded, label: "Logout",onTap: ()=>controller.signOut(),),
                  SizedBox(height: Get.height*0.05,),
                ],
              ),

        )
      ),)
    );
    
  }
}

class _DrawerBtn extends StatelessWidget {
  const _DrawerBtn({super.key, required this.icon, required this.label, this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      icon: Icon(icon,size: 15,color: onSurfaceTextColor,),
      label: Text(label,style: TextStyle(color: onSurfaceTextColor),),
    );
  }
}
