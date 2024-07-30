import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
}
