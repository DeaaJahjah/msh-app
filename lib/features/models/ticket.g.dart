// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket(
      id: json['id'] as String?,
      clientId: json['clientId'] as String?,
      clientName: json['clientName'] as String,
      phone: json['phone'] as String?,
      ticketType: json['ticketType'] as String,
      target: json['target'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'id': instance.id,
      'clientId': instance.clientId,
      'clientName': instance.clientName,
      'phone': instance.phone,
      'ticketType': instance.ticketType,
      'target': instance.target,
      'date': instance.date,
    };
