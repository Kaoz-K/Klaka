import 'package:flutter_test/flutter_test.dart';
import 'package:klaka/services/logo_fetch_service.dart';

void main() {
  group('LogoFetchService fuzzy domein-matching', () {
    test('exacte match blijft werken', () {
      expect(LogoFetchService.getLogoUrl('Albert Heijn'),
          'https://logo.clearbit.com/ah.nl');
      expect(LogoFetchService.getLogoUrl('only'),
          'https://logo.clearbit.com/only.com');
    });

    test('hele-woord fuzzy match blijft werken', () {
      // 'jumbo' komt als los woord voor in de vrije invoer.
      expect(LogoFetchService.getLogoUrl('Jumbo Supermarkt'),
          'https://logo.clearbit.com/jumbo.com');
    });

    test("'ing' matcht niet langer 'booking.com'", () {
      final url = LogoFetchService.getLogoUrl('ING');
      expect(url, isNot('https://logo.clearbit.com/booking.com'));
      expect(url, 'https://logo.clearbit.com/ing.com');
    });

    test("'colony' matcht niet langer 'only'", () {
      final url = LogoFetchService.getLogoUrl('colony');
      expect(url, isNot('https://logo.clearbit.com/only.com'));
      expect(url, 'https://logo.clearbit.com/colony.com');
    });
  });
}
