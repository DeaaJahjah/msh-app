import 'package:flutter/material.dart';
import 'package:msh_app/features/screens/admin/get_all_cvs_screen.dart';
import 'package:msh_app/features/screens/admin/get_all_docs_screen.dart';
import 'package:msh_app/features/screens/admin/get_all_passport_screen.dart';
import 'package:msh_app/features/screens/admin/get_all_tickets_screen.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الطلبات'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'CVs'),
              Tab(text: 'ترجمة أوراق'),
              Tab(text: 'جوازات السفر'),
              Tab(text: 'التذاكر'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CVListScreen(),
            TranslateDocumentListScreen(),
            PassportListScreen(),
            TicketListScreen(),
          ],
        ),
      ),
    );
  }
}
