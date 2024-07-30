import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:msh_app/core/config/widgets/custom_snackbar.dart';
import 'package:msh_app/features/models/scholarship.dart';

class SchoolerShipsDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  Future<void> addSchoolerShip({required Scholarship scholarship, required context}) async {
    try {
      await _db.collection('scholarships').add(scholarship.toJson());
      showSuccessSnackBar(context, 'تمت اضافة المنحة بنجاح');
      Navigator.of(context).pop();
    } on FirebaseException catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> updateSchoolerShip({required Scholarship scholarship, required context}) async {
    try {
      await _db.collection('scholarships').doc(scholarship.id).set(scholarship.toJson());
      showSuccessSnackBar(context, 'تمت التعديل التسجيل بنجاح');
      Navigator.of(context).pop();
    } on FirebaseException catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<List<Scholarship>> getAll() async {
    List<Scholarship> scholarships = [];
    try {
      final data = await _db.collection('scholarships').get();
      for (var doc in data.docs) {
        scholarships.add(Scholarship.fromFirestore(doc));
      }
      return scholarships;
    } on FirebaseException catch (e) {
      print(e.toString());
      return scholarships;
    }
  }

  Future<void> delete({required String id, required context}) async {
    try {
      await _db.collection('scholarships').doc(id).delete();
      showSuccessSnackBar(context, 'تمت حذف المنحة التسجيل بنجاح');
      Navigator.of(context).pop();
    } on FirebaseException catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
