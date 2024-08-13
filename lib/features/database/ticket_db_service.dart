import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:msh_app/core/config/extensions/firebase.dart';
import 'package:msh_app/core/config/widgets/custom_snackbar.dart';
import 'package:msh_app/features/models/ticket.dart';

class TicketDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  Future<void> create({required Ticket ticket, required context}) async {
    try {
      await _db.collection('tikets').add(ticket.toJson());
      showSuccessSnackBar(context, 'تمت ارسال الطلب بنجاح');
      Navigator.of(context).pop();
    } on FirebaseException catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<List<Ticket>> getAllTikets(BuildContext context) async {
    List<Ticket> cvs = [];
    try {
      QuerySnapshot<Map<String, dynamic>> data;

      if (context.firebaseUser!.photoURL == 'client') {
        data = await _db.collection('tikets').where('clientId', isEqualTo: context.firebaseUser!.uid).get();
      } else {
        data = await _db.collection('tikets').get();
      }
      for (var doc in data.docs) {
        cvs.add(Ticket.fromFirestore(doc));
      }
      return cvs;
    } on FirebaseException catch (e) {
      print(e);
      return cvs;
    }
  }
}
