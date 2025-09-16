// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ColorOfProductDataAdapter extends TypeAdapter<ColorOfProductData> {
  @override
  final int typeId = 8;

  @override
  ColorOfProductData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ColorOfProductData(
      colorHex: fields[1] as String?,
      colorName: fields[0] as String?,
      image: (fields[2] as List?)?.cast<dynamic>(),
      isMain: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ColorOfProductData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.colorName)
      ..writeByte(1)
      ..write(obj.colorHex)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.isMain);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColorOfProductDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
