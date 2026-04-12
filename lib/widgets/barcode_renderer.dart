import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart' as bw;
import '../models/barcode_format.dart';
import '../utils/barcode_utils.dart';

class BarcodeRenderer extends StatelessWidget {
  final String data;
  final BarcodeFormatType format;
  final double? width;
  final double? height;
  final bool showText;

  const BarcodeRenderer({
    super.key,
    required this.data,
    required this.format,
    this.width,
    this.height,
    this.showText = true,
  });

  @override
  Widget build(BuildContext context) {
    final isQr = isQrLike(format);
    final effectiveWidth = width ?? (isQr ? 250.0 : double.infinity);
    final effectiveHeight = height ?? (isQr ? 250.0 : 120.0);

    try {
      return bw.BarcodeWidget(
        barcode: mapToRenderBarcode(format),
        data: data,
        width: effectiveWidth,
        height: effectiveHeight,
        drawText: showText && !isQr,
        color: Colors.black,
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(8),
      );
    } catch (_) {
      // Fallback: show barcode data as text if rendering fails
      return Container(
        width: effectiveWidth,
        height: effectiveHeight,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.warning_amber, color: Colors.orange.shade700, size: 32),
              const SizedBox(height: 8),
              Text(
                data,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Courier',
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                'Kan barcode niet weergeven',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      );
    }
  }
}
