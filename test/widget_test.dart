import 'package:barcode_widget/barcode_widget.dart' as bw;
import 'package:flutter_test/flutter_test.dart';
import 'package:klaka/models/barcode_format.dart';
import 'package:klaka/utils/barcode_utils.dart';

void main() {
  group('mapToRenderBarcode', () {
    test('levert voor elk BarcodeFormatType een renderbare barcode op', () {
      for (final format in BarcodeFormatType.values) {
        expect(mapToRenderBarcode(format), isA<bw.Barcode>(),
            reason: 'geen mapping voor $format');
      }
    });

    test('qrCode mapt naar een 2D QR-barcode', () {
      expect(mapToRenderBarcode(BarcodeFormatType.qrCode).runtimeType,
          bw.Barcode.qrCode().runtimeType);
    });

    test('unknown valt veilig terug op code128', () {
      expect(mapToRenderBarcode(BarcodeFormatType.unknown).runtimeType,
          bw.Barcode.code128().runtimeType);
    });
  });
}
