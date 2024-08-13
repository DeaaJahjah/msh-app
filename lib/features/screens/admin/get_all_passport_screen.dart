import 'package:flutter/material.dart';
import 'package:msh_app/features/database/passport_db_service.dart';
import 'package:msh_app/features/models/passport_reservation.dart';
import 'package:msh_app/features/screens/widgets/passport_card.dart';

class PassportListScreen extends StatefulWidget {
  const PassportListScreen({super.key});

  @override
  _PassportListScreenState createState() => _PassportListScreenState();
}

class _PassportListScreenState extends State<PassportListScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PassportReservation>>(
      future: PassportDbService().getAllPassport(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No Passport Reservations found.'));
        }

        final passports = snapshot.data!;

        return ListView.builder(
          itemCount: passports.length,
          itemBuilder: (context, index) {
            return PassportReservationCard(reservation: passports[index]);
          },
        );
      },
    );
  }
}
