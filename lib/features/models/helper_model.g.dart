// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helper_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Helper _$HelperFromJson(Map<String, dynamic> json) {
  return Helper(
    id: json['id'] as int?,
    name: json['name'] as String?,
    phone: json['phone'] as String?,
    sign: json['sign'] as String?,
    logo: json['logo'] as String?,
    nameEn: json['name_en'] as String?,
  );
}

Map<String, dynamic> _$HelperToJson(Helper instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'sign': instance.sign,
      'logo': instance.logo,
      "name_en": instance.nameEn
    };
