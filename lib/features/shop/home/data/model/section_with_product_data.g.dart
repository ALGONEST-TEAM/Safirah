// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_with_product_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SectionAndProductDataAdapter extends TypeAdapter<SectionAndProductData> {
  @override
  final int typeId = 0;

  @override
  SectionAndProductData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SectionAndProductData(
      sections: (fields[1] as List?)?.cast<SectionData>(),
      product: fields[2] as PaginatedProductsList?,
      imageBanner: (fields[3] as List?)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, SectionAndProductData obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.sections)
      ..writeByte(2)
      ..write(obj.product)
      ..writeByte(3)
      ..write(obj.imageBanner);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SectionAndProductDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
