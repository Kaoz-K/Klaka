import 'package:hive/hive.dart';

part 'barcode_format.g.dart';

@HiveType(typeId: 1)
enum BarcodeFormatType {
  @HiveField(0)
  qrCode,
  @HiveField(1)
  ean13,
  @HiveField(2)
  ean8,
  @HiveField(3)
  code128,
  @HiveField(4)
  code39,
  @HiveField(5)
  code93,
  @HiveField(6)
  codabar,
  @HiveField(7)
  itf,
  @HiveField(8)
  upcA,
  @HiveField(9)
  upcE,
  @HiveField(10)
  pdf417,
  @HiveField(11)
  aztec,
  @HiveField(12)
  dataMatrix,
  @HiveField(13)
  unknown,
}
