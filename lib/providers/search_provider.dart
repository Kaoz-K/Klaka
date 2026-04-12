import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/loyalty_card.dart';
import 'loyalty_cards_provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredCardsProvider = Provider<List<LoyaltyCard>>((ref) {
  final cards = ref.watch(loyaltyCardsProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();
  if (query.isEmpty) return cards;
  return cards.where((c) => c.companyName.toLowerCase().contains(query)).toList();
});
