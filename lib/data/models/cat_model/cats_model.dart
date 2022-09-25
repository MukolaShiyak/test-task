import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cats_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class CatModel {
  @HiveField(0)
  final String factText;

  @HiveField(1)
  final String createdAt;

  CatModel({required this.factText, required this.createdAt});

  factory CatModel.fromJson(Map<String, dynamic> json) =>
      _$CatModelFromJson(json);
  Map<String, dynamic> toJson() => _$CatModelToJson(this);
}
