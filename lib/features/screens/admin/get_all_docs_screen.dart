import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:msh_app/features/database/translate_docs_db_service.dart';
import 'package:msh_app/features/models/translate_document.dart';
import 'package:msh_app/features/screens/widgets/doc_card.dart';

class TranslateDocumentListScreen extends StatefulWidget {
  const TranslateDocumentListScreen({super.key});

  @override
  _TranslateDocumentListScreenState createState() => _TranslateDocumentListScreenState();
}

class _TranslateDocumentListScreenState extends State<TranslateDocumentListScreen> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<TranslateDocument>> getAllDocs() async {
    List<TranslateDocument> documents = [];
    try {
      final data = await _db.collection('TranslateDocs').get();

      for (var doc in data.docs) {
        documents.add(TranslateDocument.fromFirestore(doc));
      }
      return documents;
    } on FirebaseException catch (e) {
      print(e);
      return documents;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TranslateDocument>>(
      future: TranslateDocsDbService().getAllDocs(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No Translate Documents found.'));
        }

        final translateDocuments = snapshot.data!;

        return ListView.builder(
          itemCount: translateDocuments.length,
          itemBuilder: (context, index) {
            return TranslateDocumentCard(translateDocument: translateDocuments[index]);
          },
        );
      },
    );
  }
}
