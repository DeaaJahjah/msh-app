// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scholarship.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Scholarship _$ScholarshipFromJson(Map<String, dynamic> json) => Scholarship(
      id: json['id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      link: json['link'] as String,
    );

Map<String, dynamic> _$ScholarshipToJson(Scholarship instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'link': instance.link,
    };
