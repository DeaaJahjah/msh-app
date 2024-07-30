import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'passport_reservation.g.dart';

@JsonSerializable()
class PassportReservation {
  String? id;
  final String? clientId;
  final String? clientName;
  final String? phone;
  final String passportType;

  PassportReservation({
    this.id,
    required this.clientId,
    required this.clientName,
    this.phone,
    required this.passportType,
  });

  factory PassportReservation.fromJson(Map<String, dynamic> json) => _$PassportReservationFromJson(json);

  factory PassportReservation.fromFirestore(DocumentSnapshot documentSnapshot) {
    PassportReservation reservation = PassportReservation.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    reservation = reservation.copyWith(id: documentSnapshot.id);
    return reservation;
  }

  PassportReservation copyWith({
    String? id,
    String? clientId,
    String? clientName,
    String? phone,
    String? passportType,
  }) {
    return PassportReservation(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      phone: phone ?? this.phone,
      passportType: passportType ?? this.passportType,
    );
  }

  Map<String, dynamic> toJson() => _$PassportReservationToJson(this);
}
