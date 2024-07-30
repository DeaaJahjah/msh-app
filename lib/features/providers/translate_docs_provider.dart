import 'package:flutter/material.dart';
import 'package:msh_app/core/config/constant/constant.dart';
import 'package:msh_app/features/models/translate_document.dart';

class TranslateDocsProvider extends ChangeNotifier {
  List<Document> docs = [];

  void add() {
    docs.add(Document(
        docUrl: '',
        type: docsTypes.first,
        translateLanguage: translateLang.first,
        adliyaLegalization: false,
        familyBook: false));
    notifyListeners();
  }
}
