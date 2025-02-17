import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../firebase_ref/References.dart';
class FirebaseStorageServices extends GetxService{
  Future<String?> getImage(String? imgName) async{
    if(imgName == null){
      return null;
    }
    try{
      var urlRef = firebaseStorage.child("question_paper_images").child('${imgName.toLowerCase()}.png');
      var imgUrl = await urlRef.getDownloadURL();
      return imgUrl;
    }catch(e){
      return null;
    }

  }

  Future<String?> getImageUrl(String? imgName) async{
    if(imgName == null){
      return null;
    }
    try{
      var urlRef = firebaseStorage.child("quizPapers").child('${imgName.toLowerCase()}.png');
      var imgUrl = await urlRef.getDownloadURL();
      return imgUrl;
    }catch(e){
      return null;
    }

  }
}