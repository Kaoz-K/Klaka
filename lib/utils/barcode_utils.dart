import 'package:mobile_scanner/mobile_scanner.dart' as scanner;
import 'package:barcode_widget/barcode_widget.dart' as bw;
import '../models/barcode_format.dart';

BarcodeFormatType mapScannerFormat(scanner.BarcodeFormat format) {
  switch (format) {
    case scanner.BarcodeFormat.qrCode:
      return BarcodeFormatType.qrCode;
    case scanner.BarcodeFormat.ean13:
      return BarcodeFormatType.ean13;
    case scanner.BarcodeFormat.ean8:
      return BarcodeFormatType.ean8;
    case scanner.BarcodeFormat.code128:
      return BarcodeFormatType.code128;
    case scanner.BarcodeFormat.code39:
      return BarcodeFormatType.code39;
    case scanner.BarcodeFormat.code93:
      return BarcodeFormatType.code93;
    case scanner.BarcodeFormat.codabar:
      return BarcodeFormatType.codabar;
    case scanner.BarcodeFormat.itf14:
      return BarcodeFormatType.itf;
    case scanner.BarcodeFormat.upcA:
      return BarcodeFormatType.upcA;
    case scanner.BarcodeFormat.upcE:
      return BarcodeFormatType.upcE;
    case scanner.BarcodeFormat.pdf417:
      return BarcodeFormatType.pdf417;
    case scanner.BarcodeFormat.aztec:
      return BarcodeFormatType.aztec;
    case scanner.BarcodeFormat.dataMatrix:
      return BarcodeFormatType.dataMatrix;
    default:
      return BarcodeFormatType.unknown;
  }
}

bw.Barcode mapToRenderBarcode(BarcodeFormatType format) {
  switch (format) {
    case BarcodeFormatType.qrCode:
      return bw.Barcode.qrCode();
    case BarcodeFormatType.ean13:
      return bw.Barcode.ean13();
    case BarcodeFormatType.ean8:
      return bw.Barcode.ean8();
    case BarcodeFormatType.code128:
      return bw.Barcode.code128();
    case BarcodeFormatType.code39:
      return bw.Barcode.code39();
    case BarcodeFormatType.code93:
      return bw.Barcode.code93();
    case BarcodeFormatType.codabar:
      return bw.Barcode.codabar();
    case BarcodeFormatType.itf:
      return bw.Barcode.itf();
    case BarcodeFormatType.upcA:
      return bw.Barcode.upcA();
    case BarcodeFormatType.upcE:
      return bw.Barcode.upcE();
    case BarcodeFormatType.pdf417:
      return bw.Barcode.pdf417();
    case BarcodeFormatType.aztec:
      return bw.Barcode.aztec();
    case BarcodeFormatType.dataMatrix:
      return bw.Barcode.dataMatrix();
    case BarcodeFormatType.unknown:
      return bw.Barcode.code128();
  }
}

bool isQrLike(BarcodeFormatType format) {
  return format == BarcodeFormatType.qrCode ||
      format == BarcodeFormatType.aztec ||
      format == BarcodeFormatType.dataMatrix;
}

/// Detecteert het barcode format automatisch op basis van de data string.
/// Wordt gebruikt bij handmatige invoer wanneer er geen scanner-detectie is.
BarcodeFormatType guessFormatFromData(String data) {
  if (data.isEmpty) return BarcodeFormatType.code128;

  final trimmed = data.trim();

  // Alleen cijfers?
  final isNumericOnly = RegExp(r'^\d+$').hasMatch(trimmed);

  if (isNumericOnly) {
    switch (trimmed.length) {
      case 8:
        return BarcodeFormatType.ean8;
      case 12:
        return BarcodeFormatType.upcA;
      case 13:
        return BarcodeFormatType.ean13;
      case 6:
        return BarcodeFormatType.upcE;
      default:
        // Numerieke data met andere lengte → waarschijnlijk code128
        return BarcodeFormatType.code128;
    }
  }

  // URL of lange tekst → QR code
  if (trimmed.startsWith('http://') ||
      trimmed.startsWith('https://') ||
      trimmed.length > 40) {
    return BarcodeFormatType.qrCode;
  }

  // Alfanumeriek → code128 (meest universeel)
  return BarcodeFormatType.code128;
}
