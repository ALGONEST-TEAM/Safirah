// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SectionDataAdapter extends TypeAdapter<SectionData> {
  @override
  final int typeId = 1;

  @override
  SectionData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SectionData(
      id: fields[0] as int?,
      name: fields[1] as String?,
      nameEn: fields[2] as String?,
      category: (fields[3] as List?)?.cast<CategoryData>(),
      hasSubSection: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SectionData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.nameEn)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.hasSubSection);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SectionDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
