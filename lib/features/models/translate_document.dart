import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'translate_document.g.dart';

@JsonSerializable()
class Document {
  final String docUrl;
  final String type;
  final String translateLanguage;

  final bool adliyaLegalization;
  final bool familyBook;

  Document({
    required this.docUrl,
    required this.type,
    required this.translateLanguage,
    required this.adliyaLegalization,
    required this.familyBook,
  });
  Document copyWith({
    String? docUrl,
    String? type,
    String? translateLanguage,
    bool? adliyaLegalization,
    bool? familyBook,
  }) {
    return Document(
      docUrl: docUrl ?? this.docUrl,
      type: type ?? this.type,
      translateLanguage: translateLanguage ?? this.translateLanguage,
      adliyaLegalization: adliyaLegalization ?? this.adliyaLegalization,
      familyBook: familyBook ?? this.familyBook,
    );
  }

  factory Document.fromJson(Map<String, dynamic> json) => _$DocumentFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentToJson(this);
}

@JsonSerializable()
class TranslateDocument {
  String? id;
  final String? clientId;
  final String? clientName;
  final String? phone;
  final List<Document> documents;
  final bool doYouHavePassport;

  TranslateDocument({
    this.id,
    required this.clientId,
    required this.clientName,
    this.phone,
    required this.documents,
    required this.doYouHavePassport,
  });

  factory TranslateDocument.fromJson(Map<String, dynamic> json) => _$TranslateDocumentFromJson(json);

  factory TranslateDocument.fromFirestore(DocumentSnapshot documentSnapshot) {
    TranslateDocument translateDocument = TranslateDocument.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    translateDocument = translateDocument.copyWith(id: documentSnapshot.id);
    return translateDocument;
  }

  TranslateDocument copyWith({
    String? id,
    String? clientId,
    String? clientName,
    String? phone,
    List<Document>? documents,
    bool? doYouHavePassport,
  }) {
    return TranslateDocument(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      phone: phone ?? this.phone,
      documents: documents ?? this.documents,
      doYouHavePassport: doYouHavePassport ?? this.doYouHavePassport,
    );
  }

  Map<String, dynamic> toJson() => _$TranslateDocumentToJson(this);
}
