import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket.g.dart';

@JsonSerializable()
class Ticket {
  String? id;
  final String? clientId;
  final String clientName;
  final String? phone;
  final String ticketType;
  final String target;
  final String date;

  Ticket({
    this.id,
    required this.clientId,
    required this.clientName,
    this.phone,
    required this.ticketType,
    required this.target,
    required this.date,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  factory Ticket.fromFirestore(DocumentSnapshot documentSnapshot) {
    Ticket ticket = Ticket.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    ticket = ticket.copyWith(id: documentSnapshot.id);
    return ticket;
  }

  Ticket copyWith({
    String? id,
    String? clientId,
    String? clientName,
    String? phone,
    String? ticketType,
    String? target,
    String? date,
  }) {
    return Ticket(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      phone: phone ?? this.phone,
      ticketType: ticketType ?? this.ticketType,
      target: target ?? this.target,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toJson() => _$TicketToJson(this);
}
