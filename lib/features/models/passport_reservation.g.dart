// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passport_reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PassportReservation _$PassportReservationFromJson(Map<String, dynamic> json) => PassportReservation(
      id: json['id'] as String?,
      clientId: json['clientId'] as String?,
      clientName: json['clientName'] as String?,
      phone: json['phone'] as String,
      passportType: json['passportType'] as String,
    );

Map<String, dynamic> _$PassportReservationToJson(PassportReservation instance) => <String, dynamic>{
      'id': instance.id,
      'clientId': instance.clientId,
      'clientName': instance.clientName,
      'phone': instance.phone,
      'passportType': instance.passportType,
    };
