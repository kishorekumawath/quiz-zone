import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomePaperHolder extends StatelessWidget {
  const HomePaperHolder({super.key});

  @override
  Widget build(BuildContext context) {

    var paper = Container(
      height: Get.height*0.15,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),

    );

    return Shimmer.fromColors(
      highlightColor: Colors.blueGrey.withOpacity(0.5),
      baseColor: Colors.white,
      child: EasySeparatedColumn(
        separatorBuilder: (BuildContext context, int index){
          return const SizedBox(height: 10,);
        },
        children: [
          SizedBox(height: 10,),
          paper,
          paper,
          paper,

        ],
      ),
    );
  }
}
