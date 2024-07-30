part of 'translate_document.dart';

Document _$DocumentFromJson(Map<String, dynamic> json) => Document(
      docUrl: json['docUrl'] as String,
      type: json['type'] as String,
      translateLanguage: json['translateLanguage'] as String,
      adliyaLegalization: json['adliyaLegalization'] as bool,
      familyBook: json['familyBook'] as bool,
    );

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'docUrl': instance.docUrl,
      'type': instance.type,
      'translateLanguage': instance.translateLanguage,
      'adliyaLegalization': instance.adliyaLegalization,
      'familyBook': instance.familyBook,
    };

TranslateDocument _$TranslateDocumentFromJson(Map<String, dynamic> json) => TranslateDocument(
      id: json['id'] as String?,
      clientId: json['clientId'] as String,
      clientName: json['clientName'] as String,
      phone: json['phone'] as String?,
      documents: (json['documents'] as List<dynamic>).map((e) => Document.fromJson(e as Map<String, dynamic>)).toList(),
      doYouHavePassport: json['doYouHavePassport'] as bool,
    );

Map<String, dynamic> _$TranslateDocumentToJson(TranslateDocument instance) => <String, dynamic>{
      'id': instance.id,
      'clientId': instance.clientId,
      'clientName': instance.clientName,
      'phone': instance.phone,
      'documents': instance.documents.map((e) => e.toJson()).toList(),
      'doYouHavePassport': instance.doYouHavePassport,
    };
