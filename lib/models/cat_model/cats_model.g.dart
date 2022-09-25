// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cats_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CatModelAdapter extends TypeAdapter<CatModel> {
  @override
  final int typeId = 1;

  @override
  CatModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CatModel(
      factText: fields[0] as String,
      createdAt: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CatModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.factText)
      ..writeByte(1)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CatModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatModel _$CatModelFromJson(Map<String, dynamic> json) => CatModel(
      factText: json['factText'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$CatModelToJson(CatModel instance) => <String, dynamic>{
      'factText': instance.factText,
      'createdAt': instance.createdAt,
    };
