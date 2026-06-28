import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klaka/models/barcode_format.dart';
import 'package:klaka/models/loyalty_card.dart';
import 'package:klaka/providers/loyalty_cards_provider.dart';
import 'package:klaka/providers/search_provider.dart';
import 'package:klaka/providers/sort_provider.dart';

/// Vervangt de Hive-gebonden build() door een vaste lijst, zodat de
/// sorteerlogica puur (zonder HiveService) getest kan worden.
class _FakeCardsNotifier extends LoyaltyCardsNotifier {
  _FakeCardsNotifier(this._initial);
  final List<LoyaltyCard> _initial;
  @override
  List<LoyaltyCard> build() => _initial;
}

LoyaltyCard _card(
  String id,
  String name, {
  required DateTime createdAt,
  DateTime? lastUsedAt,
  bool isFavorite = false,
}) {
  return LoyaltyCard(
    id: id,
    companyName: name,
    barcodeData: id,
    barcodeFormat: BarcodeFormatType.code128,
    createdAt: createdAt,
    lastUsedAt: lastUsedAt,
    isFavorite: isFavorite,
  );
}

ProviderContainer _containerWith(List<LoyaltyCard> cards, SortOption sort) {
  return ProviderContainer(
    overrides: [
      loyaltyCardsProvider.overrideWith(() => _FakeCardsNotifier(cards)),
      sortOptionProvider.overrideWith((ref) => sort),
    ],
  );
}

void main() {
  final d0 = DateTime(2026, 1, 1);
  final d1 = DateTime(2026, 2, 1);
  final d2 = DateTime(2026, 3, 1);

  final beta = _card('1', 'Beta', createdAt: d1, lastUsedAt: d1);
  final alpha = _card('2', 'alpha', createdAt: d2, lastUsedAt: null);
  final gamma = _card('3', 'Gamma', createdAt: d0, lastUsedAt: d2);

  test('recentlyAdded sorteert nieuwste createdAt eerst', () {
    final c = _containerWith([beta, alpha, gamma], SortOption.recentlyAdded);
    addTearDown(c.dispose);
    final ids = c.read(filteredCardsProvider).map((e) => e.id).toList();
    expect(ids, ['2', '1', '3']);
  });

  test('alphabeticalAZ sorteert hoofdletter-ongevoelig A naar Z', () {
    final c = _containerWith([beta, alpha, gamma], SortOption.alphabeticalAZ);
    addTearDown(c.dispose);
    final names =
        c.read(filteredCardsProvider).map((e) => e.companyName).toList();
    expect(names, ['alpha', 'Beta', 'Gamma']);
  });

  test('alphabeticalZA sorteert hoofdletter-ongevoelig Z naar A', () {
    final c = _containerWith([beta, alpha, gamma], SortOption.alphabeticalZA);
    addTearDown(c.dispose);
    final names =
        c.read(filteredCardsProvider).map((e) => e.companyName).toList();
    expect(names, ['Gamma', 'Beta', 'alpha']);
  });

  test('recentlyUsed zet recentst gebruikt eerst en null-lastUsedAt achteraan',
      () {
    final c = _containerWith([beta, alpha, gamma], SortOption.recentlyUsed);
    addTearDown(c.dispose);
    final ids = c.read(filteredCardsProvider).map((e) => e.id).toList();
    expect(ids, ['3', '1', '2']);
  });

  test('favorieten en niet-favorieten worden gescheiden', () {
    final fav = _card('f', 'Fav', createdAt: d2, isFavorite: true);
    final nonFav = _card('n', 'NonFav', createdAt: d1, isFavorite: false);
    final c = _containerWith([fav, nonFav], SortOption.recentlyAdded);
    addTearDown(c.dispose);
    expect(c.read(favoriteCardsProvider).map((e) => e.id).toList(), ['f']);
    expect(c.read(nonFavoriteCardsProvider).map((e) => e.id).toList(), ['n']);
  });
}
