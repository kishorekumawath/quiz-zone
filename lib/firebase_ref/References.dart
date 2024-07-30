import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final fireStore = FirebaseFirestore.instance;
final questionPaperRf = fireStore.collection('questionPapers');
final firebaseAuth = FirebaseAuth.instance;

final userRf = fireStore.collection("Users");

Reference get firebaseStorage => FirebaseStorage.instance.ref();

DocumentReference questionRF(
        {required String paperId, required String questionId}) =>
    questionPaperRf.doc(paperId).collection("questions").doc(questionId);



final quizPaperRf = fireStore.collection('quizPapers');

CollectionReference topicsRef({required String sub_id}) =>
    quizPaperRf.doc(sub_id).collection('topics');

CollectionReference questionRef({required String sub_id,required String topic_id}) =>
    quizPaperRf.doc(sub_id).collection('topics').doc(topic_id).collection("questions");
