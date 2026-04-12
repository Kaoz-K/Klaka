import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/loyalty_card.dart';
import '../services/company_data.dart';
import '../services/logo_fetch_service.dart';

class LoyaltyCardWidget extends StatelessWidget {
  final LoyaltyCard card;

  const LoyaltyCardWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    final companyInfo = findCompany(card.companyName);
    final brandColor = companyInfo?.brandColor ??
        _cardColors[card.companyName.hashCode.abs() % _cardColors.length];

    final isDark =
        ThemeData.estimateBrightnessForColor(brandColor) == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Container(
      decoration: BoxDecoration(
        color: brandColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: brandColor.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Subtiel gradient overlay voor diepte
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withValues(alpha: 0.1),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.15),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),
            ),
            // Content: logo + naam
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  // Logo gebied — neemt meeste ruimte in
                  Expanded(
                    child: Center(
                      child: _LogoWithFallback(
                        card: card,
                        textColor: textColor,
                        isDark: isDark,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Bedrijfsnaam — ALTIJD zichtbaar onderaan
                  Text(
                    card.companyName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                      letterSpacing: 0.3,
                      shadows: isDark
                          ? [
                              Shadow(
                                color: Colors.black.withValues(alpha: 0.4),
                                blurRadius: 4,
                              ),
                            ]
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Probeert meerdere logo-bronnen, fallback = volledige bedrijfsnaam.
class _LogoWithFallback extends StatelessWidget {
  final LoyaltyCard card;
  final Color textColor;
  final bool isDark;

  const _LogoWithFallback({
    required this.card,
    required this.textColor,
    required this.isDark,
  });

  List<String> _getLogoUrls() {
    final urls = <String>[];

    if (card.logoUrl != null && card.logoUrl!.isNotEmpty) {
      urls.add(card.logoUrl!);
    }

    final companyInfo = findCompany(card.companyName);
    if (companyInfo?.logoUrl != null && !urls.contains(companyInfo!.logoUrl)) {
      urls.add(companyInfo.logoUrl!);
    }

    final candidates = LogoFetchService.getLogoUrlCandidates(card.companyName);
    for (final url in candidates) {
      if (!urls.contains(url)) {
        urls.add(url);
      }
    }

    return urls;
  }

  @override
  Widget build(BuildContext context) {
    final urls = _getLogoUrls();

    if (urls.isEmpty) {
      return _buildNameFallback();
    }

    return _CascadingImage(
      urls: urls,
      fallback: _buildNameFallback(),
    );
  }

  Widget _buildNameFallback() {
    final name = card.companyName.isNotEmpty ? card.companyName : '?';
    return Text(
      name,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: textColor,
        letterSpacing: 1.0,
        shadows: isDark
            ? [
                Shadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 4,
                ),
              ]
            : null,
      ),
    );
  }
}

/// Probeert meerdere image URLs achter elkaar.
class _CascadingImage extends StatefulWidget {
  final List<String> urls;
  final Widget fallback;

  const _CascadingImage({required this.urls, required this.fallback});

  @override
  State<_CascadingImage> createState() => _CascadingImageState();
}

class _CascadingImageState extends State<_CascadingImage> {
  int _currentIndex = 0;
  bool _allFailed = false;

  @override
  Widget build(BuildContext context) {
    if (_allFailed || widget.urls.isEmpty) {
      return widget.fallback;
    }

    return CachedNetworkImage(
      key: ValueKey(widget.urls[_currentIndex]),
      imageUrl: widget.urls[_currentIndex],
      fit: BoxFit.contain,
      fadeInDuration: const Duration(milliseconds: 200),
      placeholder: (_, __) => const SizedBox.shrink(),
      errorWidget: (_, __, ___) {
        if (_currentIndex < widget.urls.length - 1) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) setState(() => _currentIndex++);
          });
          return const SizedBox.shrink();
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) setState(() => _allFailed = true);
        });
        return widget.fallback;
      },
    );
  }
}

const _cardColors = [
  Color(0xFF007AFF),
  Color(0xFF34C759),
  Color(0xFFFF9500),
  Color(0xFFFF2D55),
  Color(0xFF5856D6),
  Color(0xFFAF52DE),
  Color(0xFF00C7BE),
  Color(0xFF30B0C7),
];
