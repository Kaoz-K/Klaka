import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/loyalty_card.dart';
import 'loyalty_cards_provider.dart';
import 'sort_provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

List<LoyaltyCard> _sorted(List<LoyaltyCard> cards, SortOption sort) {
  final list = [...cards];
  switch (sort) {
    case SortOption.recentlyAdded:
      list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    case SortOption.alphabeticalAZ:
      list.sort((a, b) => a.companyName.toLowerCase().compareTo(b.companyName.toLowerCase()));
    case SortOption.alphabeticalZA:
      list.sort((a, b) => b.companyName.toLowerCase().compareTo(a.companyName.toLowerCase()));
    case SortOption.recentlyUsed:
      list.sort((a, b) {
        final au = a.lastUsedAt;
        final bu = b.lastUsedAt;
        if (au == null && bu == null) return 0;
        if (au == null) return 1;
        if (bu == null) return -1;
        return bu.compareTo(au);
      });
  }
  return list;
}

/// Flat gefilterde + gesorteerde lijst (voor zoeken).
final filteredCardsProvider = Provider<List<LoyaltyCard>>((ref) {
  final cards = ref.watch(loyaltyCardsProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final sort = ref.watch(sortOptionProvider);

  final filtered = query.isEmpty
      ? cards
      : cards.where((c) => c.companyName.toLowerCase().contains(query)).toList();

  return _sorted(filtered, sort);
});

/// Alleen favorieten (gesorteerd).
final favoriteCardsProvider = Provider<List<LoyaltyCard>>((ref) {
  final cards = ref.watch(loyaltyCardsProvider);
  final sort = ref.watch(sortOptionProvider);
  return _sorted(cards.where((c) => c.isFavorite).toList(), sort);
});

/// Alleen niet-favorieten (gesorteerd).
final nonFavoriteCardsProvider = Provider<List<LoyaltyCard>>((ref) {
  final cards = ref.watch(loyaltyCardsProvider);
  final sort = ref.watch(sortOptionProvider);
  return _sorted(cards.where((c) => !c.isFavorite).toList(), sort);
});
