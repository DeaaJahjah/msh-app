// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cv_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CVModel _$CVModelFromJson(Map<String, dynamic> json) => CVModel(
      id: json['id'] as String?,
      clientId: json['clientId'] as String?,
      clientName: json['clientName'] as String?,
      clientPhone: json['clientPhone'] as String?,
      phone: json['phone'] as String?,
      imageUrl: json['imageUrl'] as String?,
      fullName: json['fullName'] as String,
      aboutYou: json['aboutYou'] as String,
      email: json['email'] as String,
      job: json['job'] as String,
      certificates: (json['certificates'] as List<dynamic>).map((e) => e as String).toList(),
      skills: (json['skills'] as List<dynamic>).map((e) => e as String).toList(),
      softSkills: (json['softSkills'] as List<dynamic>).map((e) => e as String).toList(),
      languages: (json['languages'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CVModelToJson(CVModel instance) => <String, dynamic>{
      'id': instance.id,
      'clientId': instance.clientId,
      'clientName': instance.clientName,
      'clientPhone': instance.clientPhone,
      'phone': instance.phone,
      'imageUrl': instance.imageUrl,
      'fullName': instance.fullName,
      'aboutYou': instance.aboutYou,
      'email': instance.email,
      'job': instance.job,
      'certificates': instance.certificates,
      'skills': instance.skills,
      'softSkills': instance.softSkills,
      'languages': instance.languages,
    };
