import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:msh_app/core/config/extensions/firebase.dart';
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

  Future<List<PassportReservation>> getAllPassport(BuildContext context) async {
    List<PassportReservation> cvs = [];
    try {
      QuerySnapshot<Map<String, dynamic>> data;

      if (context.firebaseUser!.photoURL == 'client') {
        data =
            await _db.collection('passportReservations').where('clientId', isEqualTo: context.firebaseUser!.uid).get();
      } else {
        data = await _db.collection('passportReservations').get();
      }
      for (var doc in data.docs) {
        cvs.add(PassportReservation.fromFirestore(doc));
      }
      return cvs;
    } on FirebaseException catch (e) {
      print(e);
      return cvs;
    }
  }
}
