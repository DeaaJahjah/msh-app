import 'package:flutter/material.dart';
import 'package:msh_app/core/config/constant/constant.dart';
import 'package:msh_app/features/models/passport_reservation.dart';

class PassportReservationCard extends StatelessWidget {
  final PassportReservation reservation;

  const PassportReservationCard({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reservation.clientName ?? 'Unknown Client',
              style: meduimTextStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'نوع الحجز: ${reservation.passportType}',
              style: meduimTextStyle.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'اسم العميل: ${reservation.clientName ?? 'No phone number'}',
              style: meduimTextStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'رقم الهاتف: ${reservation.phone ?? 'No phone number'}',
              style: meduimTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
