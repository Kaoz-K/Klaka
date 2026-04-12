// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_format.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BarcodeFormatTypeAdapter extends TypeAdapter<BarcodeFormatType> {
  @override
  final int typeId = 1;

  @override
  BarcodeFormatType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BarcodeFormatType.qrCode;
      case 1:
        return BarcodeFormatType.ean13;
      case 2:
        return BarcodeFormatType.ean8;
      case 3:
        return BarcodeFormatType.code128;
      case 4:
        return BarcodeFormatType.code39;
      case 5:
        return BarcodeFormatType.code93;
      case 6:
        return BarcodeFormatType.codabar;
      case 7:
        return BarcodeFormatType.itf;
      case 8:
        return BarcodeFormatType.upcA;
      case 9:
        return BarcodeFormatType.upcE;
      case 10:
        return BarcodeFormatType.pdf417;
      case 11:
        return BarcodeFormatType.aztec;
      case 12:
        return BarcodeFormatType.dataMatrix;
      case 13:
        return BarcodeFormatType.unknown;
      default:
        return BarcodeFormatType.qrCode;
    }
  }

  @override
  void write(BinaryWriter writer, BarcodeFormatType obj) {
    switch (obj) {
      case BarcodeFormatType.qrCode:
        writer.writeByte(0);
        break;
      case BarcodeFormatType.ean13:
        writer.writeByte(1);
        break;
      case BarcodeFormatType.ean8:
        writer.writeByte(2);
        break;
      case BarcodeFormatType.code128:
        writer.writeByte(3);
        break;
      case BarcodeFormatType.code39:
        writer.writeByte(4);
        break;
      case BarcodeFormatType.code93:
        writer.writeByte(5);
        break;
      case BarcodeFormatType.codabar:
        writer.writeByte(6);
        break;
      case BarcodeFormatType.itf:
        writer.writeByte(7);
        break;
      case BarcodeFormatType.upcA:
        writer.writeByte(8);
        break;
      case BarcodeFormatType.upcE:
        writer.writeByte(9);
        break;
      case BarcodeFormatType.pdf417:
        writer.writeByte(10);
        break;
      case BarcodeFormatType.aztec:
        writer.writeByte(11);
        break;
      case BarcodeFormatType.dataMatrix:
        writer.writeByte(12);
        break;
      case BarcodeFormatType.unknown:
        writer.writeByte(13);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarcodeFormatTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
