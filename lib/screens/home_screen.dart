import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/loyalty_cards_provider.dart';
import '../providers/search_provider.dart';
import '../providers/sort_provider.dart';
import '../models/loyalty_card.dart';
import '../widgets/loyalty_card_widget.dart';
import '../widgets/empty_state.dart';
import 'add_card_screen.dart';
import 'detail_popup.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _isSearching = false;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(searchQueryProvider);
    final isFiltering = searchQuery.isNotEmpty;

    final filteredCards = ref.watch(filteredCardsProvider);
    final favoriteCards = ref.watch(favoriteCardsProvider);
    final nonFavoriteCards = ref.watch(nonFavoriteCardsProvider);
    final allCards = ref.watch(loyaltyCardsProvider);

    final hasFavorites = favoriteCards.isNotEmpty;
    final currentSort = ref.watch(sortOptionProvider);

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Zoek kaart...',
                  border: InputBorder.none,
                  filled: false,
                ),
                onChanged: (value) {
                  ref.read(searchQueryProvider.notifier).state = value;
                },
              )
            : const Text('Klaka'),
        leading: _isSearching
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _isSearching = false;
                    _searchController.clear();
                    ref.read(searchQueryProvider.notifier).state = '';
                  });
                },
              )
            : null,
        actions: [
          if (!_isSearching) ...[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => setState(() => _isSearching = true),
            ),
            IconButton(
              icon: const Icon(Icons.sort),
              tooltip: 'Sorteren',
              onPressed: () => _showSortOptions(currentSort),
            ),
          ],
        ],
      ),
      body: allCards.isEmpty
          ? const EmptyState()
          : isFiltering
              ? _buildFlatGrid(filteredCards)
              : _buildSectionedGrid(
                  hasFavorites: hasFavorites,
                  favoriteCards: favoriteCards,
                  nonFavoriteCards: nonFavoriteCards,
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddCardScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFlatGrid(List<LoyaltyCard> cards) {
    if (cards.isEmpty) {
      return const Center(
        child: Text(
          'Geen kaarten gevonden',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(16),
      child: _CardGrid(
        cards: cards,
        onTap: (id) => _showCardDetail(id),
        onLongPress: (id) => _showCardOptions(id),
      ),
    );
  }

  Widget _buildSectionedGrid({
    required bool hasFavorites,
    required List<LoyaltyCard> favoriteCards,
    required List<LoyaltyCard> nonFavoriteCards,
  }) {
    return CustomScrollView(
      slivers: [
        if (hasFavorites) ...[
          _sectionHeader('Favorieten'),
          _cardSliver(favoriteCards),
          if (nonFavoriteCards.isNotEmpty) ...[
            _sectionHeader('Overige kaarten'),
            _cardSliver(nonFavoriteCards, bottomPadding: true),
          ] else
            const SliverToBoxAdapter(child: SizedBox(height: 88)),
        ] else ...[
          _sectionHeader('Alle kaarten'),
          _cardSliver(nonFavoriteCards, bottomPadding: true),
        ],
      ],
    );
  }

  SliverToBoxAdapter _sectionHeader(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  SliverPadding _cardSliver(List<LoyaltyCard> cards, {bool bottomPadding = false}) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, bottomPadding ? 88 : 0),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final card = cards[index];
            return GestureDetector(
              onTap: () => _showCardDetail(card.id),
              onLongPress: () => _showCardOptions(card.id),
              child: LoyaltyCardWidget(card: card),
            );
          },
          childCount: cards.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
      ),
    );
  }

  void _showCardDetail(String cardId) {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (_) => DetailPopup(cardId: cardId),
    );
  }

  void _showSortOptions(SortOption current) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 4, 16, 8),
                child: Text(
                  'Sorteren op',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              for (final option in SortOption.values)
                ListTile(
                  title: Text(option.label),
                  trailing: current == option
                      ? Icon(
                          Icons.check_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : null,
                  onTap: () {
                    ref.read(sortOptionProvider.notifier).state = option;
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCardOptions(String cardId) {
    final card = ref.read(loyaltyCardsProvider).firstWhere((c) => c.id == cardId);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                leading: Icon(
                  card.isFavorite ? Icons.star_rounded : Icons.star_outline_rounded,
                  color: card.isFavorite ? Colors.amber.shade600 : null,
                ),
                title: Text(card.isFavorite ? 'Verwijder uit favorieten' : 'Voeg toe aan favorieten'),
                onTap: () {
                  ref.read(loyaltyCardsProvider.notifier).toggleFavorite(cardId);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Bewerken'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddCardScreen(editCard: card),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
                title: Text(
                  'Verwijderen',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _confirmDelete(cardId, card.companyName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete(String cardId, String companyName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kaart verwijderen?'),
        content: Text('Weet je zeker dat je de kaart van $companyName wilt verwijderen?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuleren'),
          ),
          TextButton(
            onPressed: () {
              ref.read(loyaltyCardsProvider.notifier).deleteCard(cardId);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Verwijderen'),
          ),
        ],
      ),
    );
  }
}

class _CardGrid extends StatelessWidget {
  final List<LoyaltyCard> cards;
  final void Function(String id) onTap;
  final void Function(String id) onLongPress;

  const _CardGrid({
    required this.cards,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];
        return GestureDetector(
          onTap: () => onTap(card.id),
          onLongPress: () => onLongPress(card.id),
          child: LoyaltyCardWidget(card: card),
        );
      },
    );
  }
}
