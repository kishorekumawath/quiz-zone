import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class questionScreenHolder extends StatelessWidget {
  const questionScreenHolder({super.key});

  @override
  Widget build(BuildContext context) {
    var line = Container(
      height: 12.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),

    );

    var answer = Container(
      height: 50.0,
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
          return const SizedBox(height: 20,);
        },
        children: [
          SizedBox(height: 20,),
          line,
          line,
          answer,
          answer,
          answer,
          answer
        ],
      ),
    );
  }
}
