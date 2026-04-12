import 'package:hive_flutter/hive_flutter.dart';
import '../models/loyalty_card.dart';
import '../models/barcode_format.dart';

class HiveService {
  static const String _boxName = 'loyalty_cards';
  static late Box<LoyaltyCard> _box;

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(LoyaltyCardAdapter());
    Hive.registerAdapter(BarcodeFormatTypeAdapter());
    _box = await Hive.openBox<LoyaltyCard>(_boxName);
  }

  static List<LoyaltyCard> getAllCards() => _box.values.toList();

  static Future<void> saveCard(LoyaltyCard card) async {
    await _box.put(card.id, card);
  }

  static Future<void> deleteCard(String id) async {
    await _box.delete(id);
  }

  static LoyaltyCard? getCard(String id) => _box.get(id);

  static bool cardExistsWithBarcode(String barcodeData) {
    return _box.values.any((c) => c.barcodeData == barcodeData);
  }

  static LoyaltyCard? getCardByBarcode(String barcodeData) {
    try {
      return _box.values.firstWhere((c) => c.barcodeData == barcodeData);
    } catch (_) {
      return null;
    }
  }
}
