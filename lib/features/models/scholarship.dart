import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'scholarship.g.dart';

@JsonSerializable()
class Scholarship {
  String? id;
  String title;
  String description;
  String imageUrl;
  String link;

  Scholarship({
    this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.link,
  });

  factory Scholarship.fromJson(Map<String, dynamic> json) => _$ScholarshipFromJson(json);

  factory Scholarship.fromFirestore(DocumentSnapshot documentSnapshot) {
    Scholarship scholarship = Scholarship.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    scholarship = scholarship.copyWith(id: documentSnapshot.id);
    return scholarship;
  }

  Scholarship copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? link,
  }) {
    return Scholarship(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toJson() => _$ScholarshipToJson(this);
}
