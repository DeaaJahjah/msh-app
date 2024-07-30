import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:msh_app/core/config/widgets/custom_snackbar.dart';
import 'package:msh_app/features/auth/models/user_model.dart';
import 'package:msh_app/splash_screen.dart';

class UserDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  Future<void> creatUser({required UserModel user, required context}) async {
    try {
      await _db.collection('users').doc(firebaseUser!.uid).set(user.toJson());
      showSuccessSnackBar(context, 'تمت عملية التسجيل بنجاح');
      Navigator.of(context).pushNamedAndRemoveUntil(SplashScreen.routeName, (route) => false);
    } on FirebaseException catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<UserModel?> geUserById(String? id) async {
    print(firebaseUser!.uid);
    var doc = await _db.collection('students').doc(id ?? firebaseUser!.uid).get();
    if (doc.exists) {
      return UserModel.fromFirestore(doc);
    }

    return null;
  }
}
