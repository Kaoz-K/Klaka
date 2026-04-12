import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/loyalty_cards_provider.dart';
import '../services/company_data.dart';
import '../widgets/barcode_renderer.dart';
import '../widgets/logo_loader.dart';
import '../utils/barcode_utils.dart';
import 'add_card_screen.dart';

class DetailPopup extends ConsumerStatefulWidget {
  final String cardId;

  const DetailPopup({super.key, required this.cardId});

  @override
  ConsumerState<DetailPopup> createState() => _DetailPopupState();
}

class _DetailPopupState extends ConsumerState<DetailPopup> {
  @override
  void initState() {
    super.initState();
    _setMaxBrightness();
  }

  @override
  void dispose() {
    _restoreBrightness();
    super.dispose();
  }

  Future<void> _setMaxBrightness() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  Future<void> _restoreBrightness() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context) {
    final cards = ref.watch(loyaltyCardsProvider);
    final card = cards.where((c) => c.id == widget.cardId).firstOrNull;

    if (card == null) {
      return const SizedBox.shrink();
    }

    final companyInfo = findCompany(card.companyName);
    final brandColor = companyInfo?.brandColor ?? const Color(0xFF1A1A2E);
    final isDark =
        ThemeData.estimateBrightnessForColor(brandColor) == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtleTextColor = isDark
        ? Colors.white.withValues(alpha: 0.7)
        : Colors.black54;

    final isQr = isQrLike(card.barcodeFormat);
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog.fullscreen(
      backgroundColor: brandColor,
      child: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.close, color: textColor, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: textColor, size: 24),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddCardScreen(editCard: card),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Logo — groot
            LogoLoader(
              assetPath: card.logoAssetPath,
              url: card.logoUrl,
              companyName: card.companyName,
              size: 100,
            ),
            const SizedBox(height: 20),

            // Bedrijfsnaam — altijd zichtbaar
            Text(
              card.companyName,
              style: TextStyle(
                color: textColor,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                shadows: isDark
                    ? [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 4,
                        ),
                      ]
                    : null,
              ),
            ),
            const SizedBox(height: 32),

            // Barcode
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: BarcodeRenderer(
                data: card.barcodeData,
                format: card.barcodeFormat,
                width: isQr ? screenWidth * 0.6 : screenWidth - 88,
                height: isQr ? screenWidth * 0.6 : 140,
              ),
            ),
            const SizedBox(height: 16),

            // Kaartnummer (tik om te kopieren)
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: card.barcodeData));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Kaartnummer gekopieerd'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              child: Text(
                card.barcodeData,
                style: TextStyle(
                  color: subtleTextColor,
                  fontSize: 16,
                  fontFamily: 'Courier',
                  letterSpacing: 2,
                ),
              ),
            ),

            if (card.notes != null && card.notes!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                card.notes!,
                style: TextStyle(
                  color: subtleTextColor.withValues(alpha: 0.5),
                  fontSize: 14,
                ),
              ),
            ],

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
