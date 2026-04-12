import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../services/company_data.dart';
import '../services/logo_fetch_service.dart';

class LogoLoader extends StatelessWidget {
  final String? assetPath;
  final String? url;
  final String companyName;
  final double size;

  const LogoLoader({
    super.key,
    this.assetPath,
    this.url,
    required this.companyName,
    this.size = 60,
  });

  List<String> _getLogoUrls() {
    final urls = <String>[];

    // 1. Meegegeven URL (van de kaart)
    if (url != null && url!.isNotEmpty) {
      urls.add(url!);
    }

    // 2. URL uit CompanyInfo database
    final companyInfo = findCompany(companyName);
    if (companyInfo?.logoUrl != null && !urls.contains(companyInfo!.logoUrl)) {
      urls.add(companyInfo.logoUrl!);
    }

    // 3. LogoFetchService candidates (Clearbit + Google favicon)
    final candidates = LogoFetchService.getLogoUrlCandidates(companyName);
    for (final c in candidates) {
      if (!urls.contains(c)) {
        urls.add(c);
      }
    }

    return urls;
  }

  @override
  Widget build(BuildContext context) {
    // Probeer asset eerst
    if (assetPath != null && assetPath!.isNotEmpty) {
      return Image.asset(
        assetPath!,
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => _buildNameFallback(),
      );
    }

    final urls = _getLogoUrls();
    if (urls.isEmpty) {
      return _buildNameFallback();
    }

    return SizedBox(
      width: size,
      height: size,
      child: _CascadingLogo(
        urls: urls,
        size: size,
        fallback: _buildNameFallback(),
      ),
    );
  }

  Widget _buildNameFallback() {
    final name = companyName.isNotEmpty ? companyName : '?';
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Text(
          name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: size * 0.25,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

/// Probeert meerdere image URLs achter elkaar tot er een lukt.
class _CascadingLogo extends StatefulWidget {
  final List<String> urls;
  final double size;
  final Widget fallback;

  const _CascadingLogo({
    required this.urls,
    required this.size,
    required this.fallback,
  });

  @override
  State<_CascadingLogo> createState() => _CascadingLogoState();
}

class _CascadingLogoState extends State<_CascadingLogo> {
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
      width: widget.size,
      height: widget.size,
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
