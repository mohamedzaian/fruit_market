// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductmodelAdapter extends TypeAdapter<Productmodel> {
  @override
  final int typeId = 0;

  @override
  Productmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Productmodel(
      name: fields[0] as String,
      price: fields[1] as double,
      category: fields[2] as String,
      image: fields[3] as String,
      details: fields[5] as String,
    )..isFavorite = fields[4] as bool;
  }

  @override
  void write(BinaryWriter writer, Productmodel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.isFavorite)
      ..writeByte(5)
      ..write(obj.details);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
