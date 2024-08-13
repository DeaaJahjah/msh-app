import 'package:flutter/material.dart';
import 'package:msh_app/core/config/constant/constant.dart';
import 'package:msh_app/features/models/translate_document.dart';

class TranslateDocumentCard extends StatelessWidget {
  final TranslateDocument translateDocument;

  const TranslateDocumentCard({super.key, required this.translateDocument});

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
              translateDocument.clientName ?? 'Unknown Client',
              style: meduimTextStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'رقم الهاتف: ${translateDocument.phone ?? 'No phone number'}',
              style: meduimTextStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'هل لديك جواز سفر: ${translateDocument.doYouHavePassport ? 'نعم' : 'لا'}',
              style: meduimTextStyle,
            ),
            const SizedBox(height: 8),
            const Text(
              'الأوراق:',
              style: meduimTextStyle,
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: translateDocument.documents.map((doc) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    '${doc.type} (لغة الترجمة - ${doc.translateLanguage}) \nتصديق عدلية: ${doc.adliyaLegalization ? 'نعم' : 'لا'}',
                    style: meduimTextStyle,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
