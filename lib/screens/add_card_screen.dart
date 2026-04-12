import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/loyalty_card.dart';
import '../models/barcode_format.dart';
import '../providers/loyalty_cards_provider.dart';
import '../services/company_data.dart';
import '../services/hive_service.dart';
import '../services/logo_fetch_service.dart';
import '../widgets/company_dropdown.dart';
import '../widgets/logo_loader.dart';
import '../utils/id_generator.dart';
import '../utils/barcode_utils.dart';
import 'scanner_screen.dart';

class AddCardScreen extends ConsumerStatefulWidget {
  final LoyaltyCard? editCard;

  const AddCardScreen({super.key, this.editCard});

  @override
  ConsumerState<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends ConsumerState<AddCardScreen> {
  final _companyController = TextEditingController();
  final _barcodeController = TextEditingController();
  final _notesController = TextEditingController();
  BarcodeFormatType _selectedFormat = BarcodeFormatType.code128;
  bool _formatDetectedByScanner = false;
  String? _logoUrl;
  String? _logoAssetPath;

  bool get _isEditing => widget.editCard != null;

  bool get _canSave =>
      _companyController.text.trim().isNotEmpty &&
      _barcodeController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      final card = widget.editCard!;
      _companyController.text = card.companyName;
      _barcodeController.text = card.barcodeData;
      _notesController.text = card.notes ?? '';
      _selectedFormat = card.barcodeFormat;
      _formatDetectedByScanner = true; // Bij bewerken: format al bekend
      _logoUrl = card.logoUrl;
      _logoAssetPath = card.logoAssetPath;
    }
  }

  @override
  void dispose() {
    _companyController.dispose();
    _barcodeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _scanBarcode() async {
    final result = await Navigator.push<ScanResult>(
      context,
      MaterialPageRoute(builder: (_) => const ScannerScreen()),
    );

    if (result != null && mounted) {
      setState(() {
        _barcodeController.text = result.data;
        _selectedFormat = result.format;
        _formatDetectedByScanner = true;
      });

      // If company name is already filled, auto-save and go back
      if (_companyController.text.trim().isNotEmpty) {
        _saveCard();
      }
    }
  }

  void _onBarcodeChanged(String value) {
    setState(() {
      // Alleen auto-detecteren als de scanner het format niet al heeft bepaald
      if (!_formatDetectedByScanner && value.isNotEmpty) {
        _selectedFormat = guessFormatFromData(value);
      }
    });
  }

  void _saveCard() {
    if (!_canSave) return;

    final companyName = _companyController.text.trim();
    final barcodeData = _barcodeController.text.trim();

    // Als format niet door scanner gedetecteerd is, raad het op basis van data
    if (!_formatDetectedByScanner) {
      _selectedFormat = guessFormatFromData(barcodeData);
    }

    // Check for duplicates (only when adding new cards)
    if (!_isEditing && HiveService.cardExistsWithBarcode(barcodeData)) {
      final existing = HiveService.getCardByBarcode(barcodeData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Deze barcode is al opgeslagen als "${existing?.companyName ?? "onbekend"}"',
          ),
        ),
      );
      return;
    }

    // Auto-fetch logo als er nog geen logo is ingesteld
    final logoUrl = _logoUrl ?? LogoFetchService.getLogoUrl(companyName);

    if (_isEditing) {
      final updated = widget.editCard!.copyWith(
        companyName: companyName,
        barcodeData: barcodeData,
        barcodeFormat: _selectedFormat,
        logoUrl: logoUrl,
        logoAssetPath: _logoAssetPath,
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
      );
      ref.read(loyaltyCardsProvider.notifier).updateCard(updated);
    } else {
      final card = LoyaltyCard(
        id: generateId(),
        companyName: companyName,
        barcodeData: barcodeData,
        barcodeFormat: _selectedFormat,
        logoUrl: logoUrl,
        logoAssetPath: _logoAssetPath,
        createdAt: DateTime.now().toUtc(),
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
      );
      ref.read(loyaltyCardsProvider.notifier).addCard(card);
    }

    Navigator.pop(context);
  }

  void _onCompanySelected(CompanyInfo? company) {
    if (company != null) {
      setState(() {
        _logoAssetPath = company.logoAssetPath;
        // Gebruik bekende logo URL, of fetch automatisch
        _logoUrl = company.logoUrl ?? LogoFetchService.getLogoUrl(company.name);
      });
    }
  }

  void _onCustomNameEntered() {
    // Bij vrije invoer: probeer automatisch een logo op te halen
    final name = _companyController.text.trim();
    if (name.length >= 2) {
      final known = findCompany(name);
      if (known != null) {
        // Bekende naam getypt → gebruik bekende info
        setState(() {
          _logoAssetPath = known.logoAssetPath;
          _logoUrl = known.logoUrl ?? LogoFetchService.getLogoUrl(known.name);
        });
      } else {
        // Onbekend bedrijf → fetch logo van internet
        setState(() {
          _logoAssetPath = null;
          _logoUrl = LogoFetchService.getLogoUrl(name);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final companyName = _companyController.text.trim();

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Kaart bewerken' : 'Kaart toevoegen'),
        actions: [
          if (_isEditing)
            IconButton(
              icon: Icon(Icons.delete,
                  color: Theme.of(context).colorScheme.error),
              onPressed: _confirmDelete,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logo preview (als er een naam is ingevuld)
            if (companyName.isNotEmpty) ...[
              Center(
                child: LogoLoader(
                  assetPath: _logoAssetPath,
                  url: _logoUrl,
                  companyName: companyName,
                  size: 80,
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Company name
            CompanyDropdown(
              controller: _companyController,
              onSelected: _onCompanySelected,
              onCustomNameEntered: _onCustomNameEntered,
            ),
            const SizedBox(height: 20),

            // Scan button
            SizedBox(
              height: 52,
              child: OutlinedButton.icon(
                onPressed: _scanBarcode,
                icon: const Icon(Icons.qr_code_scanner),
                label: Text(
                  _barcodeController.text.isEmpty
                      ? 'Barcode scannen'
                      : 'Opnieuw scannen',
                ),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Manual barcode entry
            TextField(
              controller: _barcodeController,
              decoration: const InputDecoration(
                labelText: 'Kaartnummer',
                hintText: 'Of voer het nummer handmatig in',
                prefixIcon: Icon(Icons.numbers),
              ),
              onChanged: _onBarcodeChanged,
            ),

            // Toon gedetecteerd format als info (niet bewerkbaar door gebruiker)
            if (_barcodeController.text.isNotEmpty) ...[
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  'Type: ${_formatDisplayName(_selectedFormat)}${_formatDetectedByScanner ? ' (gescand)' : ' (automatisch)'}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),

            // Notes
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notities (optioneel)',
                hintText: 'Bijv. klantnummer, punten...',
                prefixIcon: Icon(Icons.note),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 32),

            // Save button
            SizedBox(
              height: 52,
              child: FilledButton(
                onPressed: _canSave ? _saveCard : null,
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  _isEditing ? 'Opslaan' : 'Kaart toevoegen',
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kaart verwijderen?'),
        content: Text(
          'Weet je zeker dat je de kaart van ${widget.editCard!.companyName} wilt verwijderen?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuleren'),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(loyaltyCardsProvider.notifier)
                  .deleteCard(widget.editCard!.id);
              Navigator.pop(context); // close dialog
              Navigator.pop(context); // close edit screen
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

  String _formatDisplayName(BarcodeFormatType format) {
    switch (format) {
      case BarcodeFormatType.qrCode:
        return 'QR Code';
      case BarcodeFormatType.ean13:
        return 'EAN-13';
      case BarcodeFormatType.ean8:
        return 'EAN-8';
      case BarcodeFormatType.code128:
        return 'Code 128';
      case BarcodeFormatType.code39:
        return 'Code 39';
      case BarcodeFormatType.code93:
        return 'Code 93';
      case BarcodeFormatType.codabar:
        return 'Codabar';
      case BarcodeFormatType.itf:
        return 'ITF';
      case BarcodeFormatType.upcA:
        return 'UPC-A';
      case BarcodeFormatType.upcE:
        return 'UPC-E';
      case BarcodeFormatType.pdf417:
        return 'PDF417';
      case BarcodeFormatType.aztec:
        return 'Aztec';
      case BarcodeFormatType.dataMatrix:
        return 'Data Matrix';
      case BarcodeFormatType.unknown:
        return 'Onbekend';
    }
  }
}
