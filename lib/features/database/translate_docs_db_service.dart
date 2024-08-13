import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:msh_app/core/config/extensions/firebase.dart';
import 'package:msh_app/core/config/widgets/custom_snackbar.dart';
import 'package:msh_app/features/models/translate_document.dart';

class TranslateDocsDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  Future<void> create({required TranslateDocument doc, required context}) async {
    try {
      await _db.collection('TranslateDocs').add(doc.toJson());
      showSuccessSnackBar(context, 'تمت ارسال الطلب بنجاح');
      Navigator.of(context).pop();
    } on FirebaseException catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<List<TranslateDocument>> getAllDocs(BuildContext context) async {
    List<TranslateDocument> cvs = [];
    try {
      QuerySnapshot<Map<String, dynamic>> data;

      if (context.firebaseUser!.photoURL == 'client') {
        data = await _db.collection('TranslateDocs').where('clientId', isEqualTo: context.firebaseUser!.uid).get();
      } else {
        data = await _db.collection('TranslateDocs').get();
      }
      for (var doc in data.docs) {
        cvs.add(TranslateDocument.fromFirestore(doc));
      }
      return cvs;
    } on FirebaseException catch (e) {
      print(e);
      return cvs;
    }
  }
}
