import 'package:hive/hive.dart';
import 'barcode_format.dart';

part 'loyalty_card.g.dart';

@HiveType(typeId: 0)
class LoyaltyCard extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String companyName;

  @HiveField(2)
  String barcodeData;

  @HiveField(3)
  BarcodeFormatType barcodeFormat;

  @HiveField(4)
  String? logoUrl;

  @HiveField(5)
  String? logoAssetPath;

  @HiveField(6)
  DateTime createdAt;

  @HiveField(7)
  String? notes;

  @HiveField(8)
  bool isFavorite;

  @HiveField(9)
  DateTime? lastUsedAt;

  LoyaltyCard({
    required this.id,
    required this.companyName,
    required this.barcodeData,
    required this.barcodeFormat,
    this.logoUrl,
    this.logoAssetPath,
    required this.createdAt,
    this.notes,
    this.isFavorite = false,
    this.lastUsedAt,
  });

  LoyaltyCard copyWith({
    String? companyName,
    String? barcodeData,
    BarcodeFormatType? barcodeFormat,
    String? logoUrl,
    String? logoAssetPath,
    String? notes,
    bool? isFavorite,
    DateTime? lastUsedAt,
  }) {
    return LoyaltyCard(
      id: id,
      companyName: companyName ?? this.companyName,
      barcodeData: barcodeData ?? this.barcodeData,
      barcodeFormat: barcodeFormat ?? this.barcodeFormat,
      logoUrl: logoUrl ?? this.logoUrl,
      logoAssetPath: logoAssetPath ?? this.logoAssetPath,
      createdAt: createdAt,
      notes: notes ?? this.notes,
      isFavorite: isFavorite ?? this.isFavorite,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
    );
  }
}
