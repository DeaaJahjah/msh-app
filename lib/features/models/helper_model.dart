import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'helper_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Helper extends Equatable {
  final int? id;
  final String? name;
  final String? phone;
  final String? sign;
  final String? logo;
  @JsonKey(name: 'name_en')
  final String? nameEn;
  const Helper(
      {required this.id,
      required this.name,
      this.phone,
      this.sign,
      this.logo,
      this.nameEn});
  factory Helper.fromJson(Map<String, dynamic> json) => _$HelperFromJson(json);
  //
  Map<String, dynamic> toJson() => _$HelperToJson(this);

  // @override
  // String toString() {
  //   return 'id $id | name: $name  | nameEn: $nameEn';
  // }

  @override
  List<Object?> get props => [
        id,
        name,
        nameEn,
        phone,
        sign,
        logo,
      ];
}
