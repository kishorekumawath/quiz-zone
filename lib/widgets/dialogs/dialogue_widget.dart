import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialogs{
  static final Dialogs _singleton = Dialogs._internal();
  Dialogs._internal();
  factory Dialogs(){
    return _singleton;
  }
  static Widget questionStartDialogue({required VoidCallback onTap}){
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Hi......."),
          Text("please login before you start"),
        ],
      ),
      actions: [
        TextButton(onPressed: onTap, child: Text("confirm"))
      ],
    );
  }

}