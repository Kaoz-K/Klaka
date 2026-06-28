import 'package:flutter_test/flutter_test.dart';
import 'package:klaka/models/barcode_format.dart';
import 'package:klaka/utils/barcode_utils.dart';

void main() {
  group('guessFormatFromData', () {
    test('lege string valt terug op code128', () {
      expect(guessFormatFromData(''), BarcodeFormatType.code128);
    });

    test('8 cijfers -> ean8', () {
      expect(guessFormatFromData('12345678'), BarcodeFormatType.ean8);
    });

    test('12 cijfers -> upcA', () {
      expect(guessFormatFromData('012345678905'), BarcodeFormatType.upcA);
    });

    test('13 cijfers -> ean13', () {
      expect(guessFormatFromData('4006381333931'), BarcodeFormatType.ean13);
    });

    test('6 cijfers -> upcE', () {
      expect(guessFormatFromData('123456'), BarcodeFormatType.upcE);
    });

    test('numeriek met afwijkende lengte -> code128', () {
      expect(guessFormatFromData('12345'), BarcodeFormatType.code128);
      expect(guessFormatFromData('1234567890'), BarcodeFormatType.code128);
    });

    test('http-url -> qrCode', () {
      expect(guessFormatFromData('http://example.com'), BarcodeFormatType.qrCode);
    });

    test('https-url -> qrCode', () {
      expect(
          guessFormatFromData('https://klaka.app/card/123'), BarcodeFormatType.qrCode);
    });

    test('lange tekst (>40 tekens) -> qrCode', () {
      final long = 'A' * 41;
      expect(guessFormatFromData(long), BarcodeFormatType.qrCode);
    });

    test('korte alfanumerieke tekst -> code128', () {
      expect(guessFormatFromData('ABC123'), BarcodeFormatType.code128);
    });

    test('omringende spaties worden getrimd voor detectie', () {
      expect(guessFormatFromData('  12345678  '), BarcodeFormatType.ean8);
    });
  });

  group('isQrLike', () {
    test('2D-formaten zijn QR-achtig', () {
      expect(isQrLike(BarcodeFormatType.qrCode), isTrue);
      expect(isQrLike(BarcodeFormatType.aztec), isTrue);
      expect(isQrLike(BarcodeFormatType.dataMatrix), isTrue);
    });

    test('1D-formaten zijn niet QR-achtig', () {
      expect(isQrLike(BarcodeFormatType.ean13), isFalse);
      expect(isQrLike(BarcodeFormatType.code128), isFalse);
      expect(isQrLike(BarcodeFormatType.upcA), isFalse);
    });
  });
}
