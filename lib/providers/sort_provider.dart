import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SortOption {
  recentlyAdded,
  alphabeticalAZ,
  alphabeticalZA,
  recentlyUsed,
}

extension SortOptionLabel on SortOption {
  String get label {
    switch (this) {
      case SortOption.recentlyAdded:
        return 'Nieuwste eerst';
      case SortOption.alphabeticalAZ:
        return 'A → Z';
      case SortOption.alphabeticalZA:
        return 'Z → A';
      case SortOption.recentlyUsed:
        return 'Recentst gebruikt';
    }
  }
}

final sortOptionProvider = StateProvider<SortOption>((ref) => SortOption.recentlyAdded);
