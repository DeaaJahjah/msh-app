import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:msh_app/core/config/widgets/custom_snackbar.dart';
import 'package:msh_app/features/models/passport_reservation.dart';

class PassportDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  Future<void> create({required PassportReservation passport, required context}) async {
    try {
      await _db.collection('passportReservations').add(passport.toJson());
      showSuccessSnackBar(context, 'تمت ارسال الطلب بنجاح');

      Navigator.of(context).pop();
      // if (context.firebaseUser != null) {
      //   CustomDialogs(context).showbottomSheetDialog(widget: const ThanksScreen());
      // } else {
      //   CustomDialogs(context).showbottomSheetDialog(widget: const ThanksScreen());
      // }
    } on FirebaseException catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
