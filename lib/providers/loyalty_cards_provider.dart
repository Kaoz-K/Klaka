import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/loyalty_card.dart';
import '../services/hive_service.dart';
import '../services/logo_fetch_service.dart';

class LoyaltyCardsNotifier extends Notifier<List<LoyaltyCard>> {
  @override
  List<LoyaltyCard> build() {
    final cards = HiveService.getAllCards();
    _fixMissingLogos(cards);
    return cards;
  }

  void _fixMissingLogos(List<LoyaltyCard> cards) {
    for (final card in cards) {
      if (card.logoUrl == null && card.logoAssetPath == null) {
        final logoUrl = LogoFetchService.getLogoUrl(card.companyName);
        if (logoUrl != null) {
          card.logoUrl = logoUrl;
          HiveService.saveCard(card);
        }
      }
    }
  }

  Future<void> addCard(LoyaltyCard card) async {
    await HiveService.saveCard(card);
    state = [...state, card];
  }

  Future<void> updateCard(LoyaltyCard card) async {
    await HiveService.saveCard(card);
    state = [
      for (final c in state)
        if (c.id == card.id) card else c,
    ];
  }

  Future<void> deleteCard(String id) async {
    await HiveService.deleteCard(id);
    state = state.where((c) => c.id != id).toList();
  }

  Future<void> toggleFavorite(String id) async {
    final card = state.firstWhere((c) => c.id == id);
    final updated = card.copyWith(isFavorite: !card.isFavorite);
    await HiveService.saveCard(updated);
    state = [for (final c in state) if (c.id == id) updated else c];
  }

  Future<void> markAsUsed(String id) async {
    final card = state.firstWhere((c) => c.id == id);
    final updated = card.copyWith(lastUsedAt: DateTime.now());
    await HiveService.saveCard(updated);
    state = [for (final c in state) if (c.id == id) updated else c];
  }
}

final loyaltyCardsProvider =
    NotifierProvider<LoyaltyCardsNotifier, List<LoyaltyCard>>(
  LoyaltyCardsNotifier.new,
);
