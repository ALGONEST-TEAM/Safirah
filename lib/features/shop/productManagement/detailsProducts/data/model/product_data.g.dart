// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductDataAdapter extends TypeAdapter<ProductData> {
  @override
  final int typeId = 5;

  @override
  ProductData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductData(
      id: fields[0] as int?,
      name: fields[1] as String?,
      price: fields[2] as dynamic,
      categoryId: fields[3] as int?,
      discount: fields[4] as String?,
      description: fields[5] as String?,
      currency: fields[6] as String?,
      mainImage: (fields[9] as List?)?.cast<String>(),
      discountModel: fields[11] as DiscountModel?,
      priceAfterDiscount: fields[12] as dynamic,
      coponPrice: fields[13] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, ProductData obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.categoryId)
      ..writeByte(4)
      ..write(obj.discount)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.currency)
      ..writeByte(9)
      ..write(obj.mainImage)
      ..writeByte(11)
      ..write(obj.discountModel)
      ..writeByte(12)
      ..write(obj.priceAfterDiscount)
      ..writeByte(13)
      ..write(obj.coponPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
