import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_zone/config/theme/app_colors.dart';

class BackGroundDecoration extends StatelessWidget {
  const BackGroundDecoration({super.key, required this.child, required this.appbar, this.showGradient=false});
  final Widget child;
  final Widget appbar;
  final bool showGradient;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: showGradient?null:Theme.of(context).primaryColor,
                gradient: showGradient?mainGradient():null,
              ),
              child: CustomPaint(
                painter: BackgroundPainter(),
              ),
            ),
          ),
          Positioned(top: Get.height*0.08,child: appbar,),
          Positioned(
              child: child),
        ],
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white.withOpacity(0.1);
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width*0.2, 0);
    path.lineTo(0, size.height*0.4);
    path.close();

    Path path1 = Path();
    path1.moveTo(size.width, 0);
    path1.lineTo(size.width*0.8, 0);
    path1.lineTo(size.width*0.2, size.height);
    path1.lineTo(size.width, size.height);
    path1.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path1, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

