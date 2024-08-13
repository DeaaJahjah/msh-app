import 'package:flutter/material.dart';
import 'package:msh_app/core/config/constant/constant.dart';
import 'package:msh_app/features/models/ticket.dart';

class TicketCard extends StatelessWidget {
  final Ticket ticket;

  const TicketCard({super.key, required this.ticket});

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
              ticket.clientName,
              style: meduimTextStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'نوع الحجز: ${ticket.ticketType}',
              style: meduimTextStyle.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'الوجهة: ${ticket.target}',
              style: meduimTextStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'التاريخ: ${ticket.date}',
              style: meduimTextStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'رقم الهاتف: ${ticket.phone ?? 'No phone number'}',
              style: meduimTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
