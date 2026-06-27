import 'package:cached_network_image/cached_network_image.dart';

/// Service die automatisch een logo URL genereert op basis van bedrijfsnaam.
/// Gebruikt Clearbit Logo API (gratis, hoge kwaliteit).
class LogoFetchService {
  /// Genereert een logo URL voor een bedrijfsnaam.
  static String? getLogoUrl(String companyName) {
    if (companyName.trim().isEmpty) return null;

    final domain = _guessDomain(companyName);
    if (domain != null) {
      return 'https://logo.clearbit.com/$domain';
    }

    return null;
  }

  /// Geeft meerdere mogelijke logo URLs terug als fallback.
  static List<String> getLogoUrlCandidates(String companyName) {
    if (companyName.trim().isEmpty) return [];

    final candidates = <String>[];
    final domain = _guessDomain(companyName);

    if (domain != null) {
      candidates.add('https://logo.clearbit.com/$domain');
      candidates.add(
          'https://www.google.com/s2/favicons?domain=$domain&sz=128');
    }

    return candidates;
  }

  /// Raad het domein van een bedrijfsnaam.
  static String? _guessDomain(String companyName) {
    final lower = companyName.trim().toLowerCase();

    // Uitgebreide bekende mappings (140+ bedrijven)
    const domainMap = <String, String>{
      // Supermarkten
      'albert heijn': 'ah.nl',
      'jumbo': 'jumbo.com',
      'lidl': 'lidl.nl',
      'plus': 'plus.nl',
      'dirk': 'dirk.nl',
      'coop': 'coop.nl',
      'spar': 'spar.nl',
      'dekamarkt': 'dekamarkt.nl',
      'hoogvliet': 'hoogvliet.com',
      'poiesz': 'poiesz-supermarkten.nl',
      'jan linders': 'janlinders.nl',
      'picnic': 'picnic.app',
      'aldi': 'aldi.nl',
      // Drogisterijen
      'kruidvat': 'kruidvat.nl',
      'etos': 'etos.nl',
      'trekpleister': 'trekpleister.nl',
      'da drogist': 'da.nl',
      'da': 'da.nl',
      // Warenhuizen
      'hema': 'hema.nl',
      'bijenkorf': 'debijenkorf.nl',
      'de bijenkorf': 'debijenkorf.nl',
      // Bouwmarkten
      'praxis': 'praxis.nl',
      'gamma': 'gamma.nl',
      'karwei': 'karwei.nl',
      'hornbach': 'hornbach.nl',
      'hubo': 'hubo.nl',
      // Elektronica
      'mediamarkt': 'mediamarkt.nl',
      'coolblue': 'coolblue.nl',
      'bcc': 'bcc.nl',
      // Mode
      'h&m': 'hm.com',
      'zara': 'zara.com',
      'c&a': 'c-and-a.com',
      'primark': 'primark.com',
      'we fashion': 'wefashion.com',
      'zeeman': 'zeeman.com',
      'scotch & soda': 'scotchandsoda.com',
      'only': 'only.com',
      'vero moda': 'veromoda.com',
      'jack & jones': 'jackjones.com',
      'mango': 'mango.com',
      'uniqlo': 'uniqlo.com',
      'bershka': 'bershka.com',
      'pull & bear': 'pullandbear.com',
      'stradivarius': 'stradivarius.com',
      'massimo dutti': 'massimodutti.com',
      'the sting': 'thesting.com',
      'america today': 'america-today.com',
      'sissy-boy': 'sissy-boy.com',
      'hunkemöller': 'hunkemoller.nl',
      'hunkemoller': 'hunkemoller.nl',
      'g-star': 'g-star.com',
      'esprit': 'esprit.nl',
      'tommy hilfiger': 'tommy.com',
      "levi's": 'levi.com',
      'levis': 'levi.com',
      'snipes': 'snipes.com',
      'tk maxx': 'tkmaxx.nl',
      'wibra': 'wibra.nl',
      // Sport
      'decathlon': 'decathlon.nl',
      'intersport': 'intersport.nl',
      'jd sports': 'jdsports.nl',
      'sport 2000': 'sport2000.nl',
      'bever': 'bever.nl',
      'nike': 'nike.com',
      'adidas': 'adidas.nl',
      'foot locker': 'footlocker.nl',
      // Dieren
      'pets place': 'petsplace.nl',
      'jumper': 'jumper.nl',
      // Boekhandel
      'bruna': 'bruna.nl',
      'ako': 'ako.nl',
      // Tuincentra
      'intratuin': 'intratuin.nl',
      'groenrijk': 'groenrijk.nl',
      // Woonwinkels
      'ikea': 'ikea.com',
      'kwantum': 'kwantum.nl',
      'jysk': 'jysk.nl',
      'leen bakker': 'leenbakker.nl',
      'leenbakker': 'leenbakker.nl',
      'xenos': 'xenos.nl',
      'blokker': 'blokker.nl',
      'casa': 'casashops.com',
      'loods 5': 'loods5.nl',
      'swiss sense': 'swisssense.nl',
      'beter bed': 'beterbed.nl',
      // Restaurants
      "mcdonald's": 'mcdonalds.nl',
      'mcdonalds': 'mcdonalds.nl',
      'starbucks': 'starbucks.nl',
      'subway': 'subway.com',
      'burger king': 'burgerking.nl',
      'kfc': 'kfc.nl',
      "domino's": 'dominos.nl',
      'dominos': 'dominos.nl',
      'new york pizza': 'newyorkpizza.nl',
      'la place': 'laplace.com',
      'febo': 'febo.nl',
      'bakker bart': 'bakkerbart.nl',
      // Tankstations
      'shell': 'shell.com',
      'bp': 'bp.com',
      'totalenergies': 'totalenergies.com',
      'total': 'totalenergies.com',
      'esso': 'esso.nl',
      'tango': 'tango.nl',
      'tinq': 'tinq.nl',
      // Schoenen
      'vanharen': 'vanharen.nl',
      'bristol': 'bristol.nl',
      'sacha': 'sacha.nl',
      'nelson': 'nelson.nl',
      'omoda': 'omoda.nl',
      // Beauty
      'douglas': 'douglas.nl',
      'rituals': 'rituals.com',
      'ici paris xl': 'iciparisxl.nl',
      'sephora': 'sephora.com',
      'the body shop': 'thebodyshop.com',
      'lush': 'lush.com',
      // Online
      'bol.com': 'bol.com',
      'bol': 'bol.com',
      'wehkamp': 'wehkamp.nl',
      'zalando': 'zalando.nl',
      'amazon': 'amazon.nl',
      'thuisbezorgd': 'thuisbezorgd.nl',
      // Gezondheid
      'holland & barrett': 'hollandandbarrett.nl',
      'vitaminstore': 'vitaminstore.nl',
      // Speelgoed
      'intertoys': 'intertoys.nl',
      'toychamp': 'toychamp.nl',
      // Overig
      'flying tiger': 'flyingtiger.com',
      'action': 'action.com',
      'anwb': 'anwb.nl',
      'pathé': 'pathe.nl',
      'pathe': 'pathe.nl',
      'kinepolis': 'kinepolis.nl',
      'lucardi': 'lucardi.nl',
      'pearle': 'pearle.nl',
      'specsavers': 'specsavers.nl',
      'hans anders': 'hansanders.nl',
      'prenatal': 'prenatal.nl',
      'normal': 'normal.dk',
      'big bazar': 'bigbazar.nl',
      'gall & gall': 'gall.nl',
      'sligro': 'sligro.nl',
      'makro': 'makro.nl',
      'vodafone': 'vodafone.nl',
      'kpn': 'kpn.com',
      't-mobile': 't-mobile.nl',
      'ns': 'ns.nl',
      'klm': 'klm.com',
      'booking.com': 'booking.com',
      'apple': 'apple.com',
      'netflix': 'netflix.com',
      'spotify': 'spotify.com',
      // België
      'colruyt': 'colruyt.be',
      'delhaize': 'delhaize.be',
      'carrefour': 'carrefour.be',
      'proxy delhaize': 'delhaize.be',
      'fnac': 'fnac.be',
      'standaard boekhandel': 'standaardboekhandel.be',
      'zeb': 'zeb.be',
      // Duitsland
      'dm': 'dm.de',
      'rossmann': 'rossmann.de',
      'müller': 'mueller.de',
      'mueller': 'mueller.de',
      'rewe': 'rewe.de',
      'edeka': 'edeka.de',
      'kaufland': 'kaufland.de',
      'penny': 'penny.de',
      'netto': 'netto.de',
      'saturn': 'saturn.de',
      'tchibo': 'tchibo.de',
      'deichmann': 'deichmann.de',
      'thalia': 'thalia.de',
      'obi': 'obi.de',
      'bauhaus': 'bauhaus.info',
      'toom': 'toom.de',
      // Frankrijk
      'leclerc': 'e.leclerc',
      'auchan': 'auchan.fr',
      'intermarché': 'intermarche.com',
      'intermarche': 'intermarche.com',
      'casino': 'groupe-casino.fr',
      'monoprix': 'monoprix.fr',
      'picard': 'picard.fr',
      'yves rocher': 'yves-rocher.com',
      'boulanger': 'boulanger.com',
      // Verenigd Koninkrijk
      'tesco': 'tesco.com',
      'sainsburys': 'sainsburys.co.uk',
      "sainsbury's": 'sainsburys.co.uk',
      'boots': 'boots.com',
      'superdrug': 'superdrug.com',
      'waitrose': 'waitrose.com',
      'marks & spencer': 'marksandspencer.com',
      'john lewis': 'johnlewis.com',
      'argos': 'argos.co.uk',
      'nandos': 'nandos.co.uk',
      "nando's": 'nandos.co.uk',
      'costa coffee': 'costa.co.uk',
      'costa': 'costa.co.uk',
      'greggs': 'greggs.co.uk',
      'whsmith': 'whsmith.co.uk',
      'superdry': 'superdry.com',
      'next': 'next.co.uk',
      'river island': 'riverisland.com',
      'new look': 'newlook.com',
      // Verenigde Staten
      'walmart': 'walmart.com',
      'target': 'target.com',
      'costco': 'costco.com',
      'walgreens': 'walgreens.com',
      'cvs': 'cvs.com',
      'home depot': 'homedepot.com',
      'lowes': 'lowes.com',
      "lowe's": 'lowes.com',
      'best buy': 'bestbuy.com',
      'bath & body works': 'bathandbodyworks.com',
      'nordstrom': 'nordstrom.com',
      "macy's": 'macys.com',
      'macys': 'macys.com',
      'gap': 'gap.com',
      'old navy': 'oldnavy.com',
      "victoria's secret": 'victoriassecret.com',
      'ulta beauty': 'ulta.com',
      'ulta': 'ulta.com',
      'panera bread': 'panerabread.com',
      'panera': 'panerabread.com',
      'chick-fil-a': 'chick-fil-a.com',
      'chipotle': 'chipotle.com',
      'dunkin': 'dunkindonuts.com',
      // Internationaal
      'samsung': 'samsung.com',
      'lego': 'lego.com',
      'dyson': 'dyson.com',
    };

    // Exacte match
    if (domainMap.containsKey(lower)) {
      return domainMap[lower];
    }

    // Fuzzy: alleen hele-woord-treffers van een bekende key binnen de naam.
    // Substring-matching (in beide richtingen) gaf valse treffers bij korte
    // fragmenten, bijv. 'ing' -> 'booking.com' en 'colony' -> 'only'.
    for (final entry in domainMap.entries) {
      if (entry.key.length < 3) continue;
      final wholeWord = RegExp(r'\b' + RegExp.escape(entry.key) + r'\b');
      if (wholeWord.hasMatch(lower)) {
        return entry.value;
      }
    }

    // Generiek: probeer naam.com
    final sanitized = lower.replaceAll(RegExp(r'[^a-z0-9]'), '').trim();
    if (sanitized.isNotEmpty && sanitized.length >= 2) {
      return '$sanitized.com';
    }

    return null;
  }

  /// Pre-cache een logo URL
  static void precacheLogo(String url) {
    try {
      CachedNetworkImageProvider(url);
    } catch (_) {
      // Negeer fouten bij precaching
    }
  }
}
