import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:msh_app/features/database/ticket_db_service.dart';
import 'package:msh_app/features/models/ticket.dart';
import 'package:msh_app/features/screens/widgets/ticket_card.dart';

class TicketListScreen extends StatefulWidget {
  const TicketListScreen({super.key});

  @override
  _TicketListScreenState createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Ticket>> getAllTikets() async {
    List<Ticket> tickets = [];
    try {
      final data = await _db.collection('tickets').get();

      for (var doc in data.docs) {
        tickets.add(Ticket.fromFirestore(doc));
      }
      return tickets;
    } on FirebaseException catch (e) {
      print(e);
      return tickets;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Ticket>>(
      future: TicketDbService().getAllTikets(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No Tickets found.'));
        }

        final tickets = snapshot.data!;

        return ListView.builder(
          itemCount: tickets.length,
          itemBuilder: (context, index) {
            return TicketCard(ticket: tickets[index]);
          },
        );
      },
    );
  }
}
