// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_products_list_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaginatedProductsListAdapter extends TypeAdapter<PaginatedProductsList> {
  @override
  final int typeId = 2;

  @override
  PaginatedProductsList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaginatedProductsList(
      data: (fields[5] as List).cast<ProductData>(),
      currentPage: fields[1] as int,
      lastPage: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, PaginatedProductsList obj) {
    writer
      ..writeByte(3)
      ..writeByte(5)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj.currentPage)
      ..writeByte(2)
      ..write(obj.lastPage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaginatedProductsListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
