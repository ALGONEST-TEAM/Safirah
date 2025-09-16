// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_with_category_of_all_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SectionWithCategoryOfAllDataAdapter
    extends TypeAdapter<SectionWithCategoryOfAllData> {
  @override
  final int typeId = 10;

  @override
  SectionWithCategoryOfAllData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SectionWithCategoryOfAllData(
      category: (fields[3] as List?)?.cast<CategoryData>(),
      section: (fields[1] as List?)?.cast<SectionData>(),
      product: (fields[5] as List?)?.cast<ProductData>(),
    );
  }

  @override
  void write(BinaryWriter writer, SectionWithCategoryOfAllData obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.section)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.product);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SectionWithCategoryOfAllDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
