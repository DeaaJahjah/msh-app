import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cv_model.g.dart';

@JsonSerializable()
class CVModel {
  String? id;
  final String? clientId;
  final String? clientName;
  final String? clientPhone;

  final String? phone;
  final String? imageUrl;
  final String fullName;
  final String aboutYou;
  final String email;
  final String job;
  final List<String> certificates;
  final List<String> skills;
  final List<String> softSkills;
  final List<String> languages;

  CVModel({
    this.id,
    required this.clientId,
    required this.clientName,
    this.clientPhone,
    required this.phone,
    required this.imageUrl,
    required this.fullName,
    required this.aboutYou,
    required this.email,
    required this.job,
    required this.certificates,
    required this.skills,
    required this.softSkills,
    required this.languages,
  });

  factory CVModel.fromJson(Map<String, dynamic> json) => _$CVModelFromJson(json);

  factory CVModel.fromFirestore(DocumentSnapshot documentSnapshot) {
    CVModel cv = CVModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    cv = cv.copyWith(id: documentSnapshot.id);
    return cv;
  }

  CVModel copyWith({
    String? id,
    String? clientId,
    String? clientName,
    String? clientPhone,
    String? phone,
    String? imageUrl,
    String? fullName,
    String? aboutYou,
    String? email,
    String? job,
    List<String>? certificates,
    List<String>? skills,
    List<String>? softSkills,
    List<String>? languages,
  }) {
    return CVModel(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      clientPhone: clientPhone ?? this.clientPhone,
      phone: phone ?? this.phone,
      imageUrl: imageUrl ?? this.imageUrl,
      fullName: fullName ?? this.fullName,
      aboutYou: aboutYou ?? this.aboutYou,
      email: email ?? this.email,
      job: job ?? this.job,
      certificates: certificates ?? this.certificates,
      skills: skills ?? this.skills,
      softSkills: softSkills ?? this.softSkills,
      languages: languages ?? this.languages,
    );
  }

  Map<String, dynamic> toJson() => _$CVModelToJson(this);
}
