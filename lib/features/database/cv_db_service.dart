import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:msh_app/core/config/extensions/firebase.dart';
import 'package:msh_app/core/config/widgets/custom_snackbar.dart';
import 'package:msh_app/features/models/cv_model.dart';

class CvDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  Future<void> creatCv({required CVModel cv, required context}) async {
    try {
      await _db.collection('cvs').add(cv.toJson());
      showSuccessSnackBar(context, 'تمت ارسال الطلب بنجاح');
      Navigator.of(context).pop();
    } on FirebaseException catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<List<CVModel>> getCvs(BuildContext context) async {
    List<CVModel> cvs = [];
    QuerySnapshot<Map<String, dynamic>> data;
    try {
      if (context.firebaseUser!.photoURL == 'client') {
        data = await _db.collection('cvs').where('clientId', isEqualTo: context.firebaseUser!.uid).get();
      } else {
        data = await _db.collection('cvs').get();
      }

      for (var doc in data.docs) {
        cvs.add(CVModel.fromFirestore(doc));
      }
      return cvs;
    } on FirebaseException catch (e) {
      print(e);
      return cvs;
    }
  }
}
