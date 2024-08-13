import 'package:flutter/material.dart';
import 'package:msh_app/features/database/cv_db_service.dart';
import 'package:msh_app/features/models/cv_model.dart';
import 'package:msh_app/features/screens/widgets/cv_card.dart';

class CVListScreen extends StatefulWidget {
  const CVListScreen({super.key});

  @override
  _CVListScreenState createState() => _CVListScreenState();
}

class _CVListScreenState extends State<CVListScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CVModel>>(
      future: CvDbService().getCvs(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No CVs found.'));
        }

        final cvs = snapshot.data!;

        return ListView.builder(
          itemCount: cvs.length,
          itemBuilder: (context, index) {
            return CVCard(cv: cvs[index]);
          },
        );
      },
    );
  }
}
