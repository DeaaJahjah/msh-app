import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? id;
  final String name;
  final String email;
  final String job;
  final String phoneNumber;



  UserModel({
    this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.job
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  factory UserModel.fromFirestore(DocumentSnapshot documentSnapshot) {
    UserModel user = UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    user = user.copyWith(id: documentSnapshot.id);
    return user;
  }
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? job,
    String? phoneNumber,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      job: job ?? this.job,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
