import 'package:flutter/material.dart';

class CompanyInfo {
  final String name;
  final String? logoAssetPath;
  final String? logoUrl;
  final Color? brandColor;

  const CompanyInfo({
    required this.name,
    this.logoAssetPath,
    this.logoUrl,
    this.brandColor,
  });
}

const List<CompanyInfo> knownCompanies = [
  // ========================
  // 🇳🇱 NEDERLAND
  // ========================

  // === SUPERMARKTEN ===
  CompanyInfo(name: 'Albert Heijn', logoUrl: 'https://logo.clearbit.com/ah.nl', brandColor: Color(0xFF00A0E2)),
  CompanyInfo(name: 'Jumbo', logoUrl: 'https://logo.clearbit.com/jumbo.com', brandColor: Color(0xFFFFCC00)),
  CompanyInfo(name: 'Lidl', logoUrl: 'https://logo.clearbit.com/lidl.nl', brandColor: Color(0xFF0050AA)),
  CompanyInfo(name: 'Plus', logoUrl: 'https://logo.clearbit.com/plus.nl', brandColor: Color(0xFF00843D)),
  CompanyInfo(name: 'Dirk', logoUrl: 'https://logo.clearbit.com/dirk.nl', brandColor: Color(0xFFE30613)),
  CompanyInfo(name: 'Coop', logoUrl: 'https://logo.clearbit.com/coop.nl', brandColor: Color(0xFFEE7F00)),
  CompanyInfo(name: 'Spar', logoUrl: 'https://logo.clearbit.com/spar.nl', brandColor: Color(0xFF00843D)),
  CompanyInfo(name: 'DekaMarkt', logoUrl: 'https://logo.clearbit.com/dekamarkt.nl', brandColor: Color(0xFFE30613)),
  CompanyInfo(name: 'Hoogvliet', logoUrl: 'https://logo.clearbit.com/hoogvliet.com', brandColor: Color(0xFFE30613)),
  CompanyInfo(name: 'Poiesz', logoUrl: 'https://logo.clearbit.com/poiesz-supermarkten.nl', brandColor: Color(0xFF003DA5)),
  CompanyInfo(name: 'Jan Linders', logoUrl: 'https://logo.clearbit.com/janlinders.nl', brandColor: Color(0xFFE30613)),
  CompanyInfo(name: 'Picnic', logoUrl: 'https://logo.clearbit.com/picnic.app', brandColor: Color(0xFFE4002B)),
  CompanyInfo(name: 'Aldi', logoUrl: 'https://logo.clearbit.com/aldi.nl', brandColor: Color(0xFF00599D)),

  // === DROGISTERIJEN ===
  CompanyInfo(name: 'Kruidvat', logoUrl: 'https://logo.clearbit.com/kruidvat.nl', brandColor: Color(0xFFE30613)),
  CompanyInfo(name: 'Etos', logoUrl: 'https://logo.clearbit.com/etos.nl', brandColor: Color(0xFF003DA5)),
  CompanyInfo(name: 'Trekpleister', logoUrl: 'https://logo.clearbit.com/trekpleister.nl', brandColor: Color(0xFFE4002B)),
  CompanyInfo(name: 'DA Drogist', logoUrl: 'https://logo.clearbit.com/da.nl', brandColor: Color(0xFF00A550)),

  // === WARENHUIZEN ===
  CompanyInfo(name: 'HEMA', logoUrl: 'https://logo.clearbit.com/hema.nl', brandColor: Color(0xFFE30613)),
  CompanyInfo(name: 'de Bijenkorf', logoUrl: 'https://logo.clearbit.com/debijenkorf.nl', brandColor: Color(0xFF000000)),

  // === BOUWMARKTEN ===
  CompanyInfo(name: 'Praxis', logoUrl: 'https://logo.clearbit.com/praxis.nl', brandColor: Color(0xFF00843D)),
  CompanyInfo(name: 'Gamma', logoUrl: 'https://logo.clearbit.com/gamma.nl', brandColor: Color(0xFF003082)),
  CompanyInfo(name: 'Karwei', logoUrl: 'https://logo.clearbit.com/karwei.nl', brandColor: Color(0xFFE4002B)),
  CompanyInfo(name: 'Hornbach', logoUrl: 'https://logo.clearbit.com/hornbach.nl', brandColor: Color(0xFFEE7F00)),
  CompanyInfo(name: 'Hubo', logoUrl: 'https://logo.clearbit.com/hubo.nl', brandColor: Color(0xFFFFCC00)),

  // === ELEKTRONICA ===
  CompanyInfo(name: 'MediaMarkt', logoUrl: 'https://logo.clearbit.com/mediamarkt.nl', brandColor: Color(0xFFDF0000)),
  CompanyInfo(name: 'Coolblue', logoUrl: 'https://logo.clearbit.com/coolblue.nl', brandColor: Color(0xFF0090E3)),
  CompanyInfo(name: 'Bcc', logoUrl: 'https://logo.clearbit.com/bcc.nl', brandColor: Color(0xFFFF6600)),

  // === MODE / KLEDING ===
  CompanyInfo(name: 'H&M', logoUrl: 'https://logo.clearbit.com/hm.com', brandColor: Color(0xFFE50010)),
  CompanyInfo(name: 'Zara', logoUrl: 'https://logo.clearbit.com/zara.com', brandColor: Color(0xFF000000)),
  CompanyInfo(name: 'C&A', logoUrl: 'https://logo.clearbit.com/c-and-a.com', brandColor: Color(0xFFE4002B)),
  CompanyInfo(name: 'Primark', logoUrl: 'https://logo.clearbit.com/primark.com', brandColor: Color(0xFF004B87)),
  CompanyInfo(name: 'WE Fashion', logoUrl: 'https://logo.clearbit.com/wefashion.com', brandColor: Color(0xFF1A1A1A)),
  CompanyInfo(name: 'Zeeman', logoUrl: 'https://logo.clearbit.com/zeeman.com', brandColor: Color(0xFFE30613)),
  CompanyInfo(name: 'Scotch & Soda', logoUrl: 'https://logo.clearbit.com/scotchandsoda.com', brandColor: Color(0xFF1A1A1A)),
  CompanyInfo(name: 'Only', logoUrl: 'https://logo.clearbit.com/only.com', brandColor: Color(0xFF000000)),
  CompanyInfo(name: 'Vero Moda', logoUrl: 'https://logo.clearbit.com/veromoda.com', brandColor: Color(0xFF000000)),
  CompanyInfo(name: 'Jack & Jones', logoUrl: 'https://logo.clearbit.com/jackjones.com', brandColor: Color(0xFF000000)),
  CompanyInfo(name: 'Mango', logoUrl: 'https://logo.clearbit.com/mango.com', brandColor: Color(0xFF000000)),
  CompanyInfo(name: 'Uniqlo', logoUrl: 'https://logo.clearbit.com/uniqlo.com', brandColor: Color(0xFFFF0000)),
  CompanyInfo(name: 'Bershka', logoUrl: 'https://logo.clearbit.com/bershka.com', brandColor: Color(0xFF000000)),
  CompanyInfo(name: 'Pull & Bear', logoUrl: 'https://logo.clearbit.com/pullandbear.com', brandColor: Color(0xFF000000)),
  CompanyInfo(name: 'The Sting', logoUrl: 'https://logo.clearbit.com/thesting.com', brandColor: Color(0xFF000000)),
  CompanyInfo(name: 'Hunkemöller', logoUrl: 'https://logo.clearbit.com/hunkemoller.nl', brandColor: Color(0xFF1A1A2E)),
  CompanyInfo(name: 'G-Star', logoUrl: 'https://logo.clearbit.com/g-star.com', brandColor: Color(0xFF000000)),
  CompanyInfo(name: 'Esprit', logoUrl: 'https://logo.clearbit.com/esprit.nl', brandColor: Color(0xFFE30613)),
  CompanyInfo(name: 'Tommy Hilfiger', logoUrl: 'https://logo.clearbit.com/tommy.com', brandColor: Color(0xFF002244)),
  CompanyInfo(name: "Levi's", logoUrl: 'https://logo.clearbit.com/levi.com', brandColor: Color(0xFFC41230)),
  CompanyInfo(name: 'Snipes', logoUrl: 'https://logo.clearbit.com/snipes.com', brandColor: Color(0xFF000000)),
  CompanyInfo(name: 'TK Maxx', logoUrl: 'https://logo.clearbit.com/tkmaxx.nl', brandColor: Color(0xFFE4002B)),
  CompanyInfo(name: 'Wibra', logoUrl: 'https://logo.clearbit.com/wibra.nl', brandColor: Color(0xFF003DA5)),

  // === SPORT ===
  CompanyInfo(name: 'Decathlon', logoUrl: 'https://logo.clearbit.com/decathlon.nl', brandColor: Color(0xFF0082C3)),
  CompanyInfo(name: 'Intersport', logoUrl: 'https://logo.clearbit.com/intersport.nl', brandColor: Color(0xFF003DA5)),
  CompanyInfo(name: 'JD Sports', logoUrl: 'https://logo.clearbit.com/jdsports.nl', brandColor: Color(0xFF000000)),
  CompanyInfo(name: 'Sport 2000', logoUrl: 'https://logo.clearbit.com/sport2000.nl', brandColor: Color(0xFF003DA5)),
  CompanyInfo(name: 'Bever', logoUrl: 'https://logo.clearbit.com/bever.nl', brandColor: Color(0xFF003D2E)),
  CompanyInfo(name: 'Nike', logoUrl: 'https://logo.clearbit.com/nike.com', brandColor: Color(0xFF000000)),
  CompanyInfo(name: 'Adidas', logoUrl: 'https://logo.clearbit.com/adidas.nl', brandColor: Color(0xFF000000)),
  CompanyInfo(name: 'Foot Locker', logoUrl: 'https://logo.clearbit.com/footlocker.nl', brandColor: Color(0xFFE30613)),

  // === DIERENWINKEL ===
  CompanyInfo(name: 'Pets Place', logoUrl: 'https://logo.clearbit.com/petsplace.nl', brandColor: Color(0xFF00843D)),
  CompanyInfo(name: 'Jumper', logoUrl: 'https://logo.clearbit.com/jumper.nl', brandColor: Color(0xFF00A550)),

  // === BOEKHANDEL ===
  CompanyInfo(name: 'Bruna', logoUrl: 'https://logo.clearbit.com/bruna.nl', brandColor: Color(0xFFE30613)),
  CompanyInfo(name: 'Ako', logoUrl: 'https://logo.clearbit.com/ako.nl', brandColor: Color(0xFFE30613)),

  // === TUINCENTRA ===
  CompanyInfo(name: 'Intratuin', logoUrl: 'https://logo.clearbit.com/intratuin.nl', brandColor: Color(0xFF00843D)),
  CompanyInfo(name: 'GroenRijk', logoUrl: 'https://logo.clearbit.com/groenrijk.nl', brandColor: Color(0xFF00843D)),

  // === WOONWINKELS ===
  CompanyInfo(name: 'IKEA', logoUrl: 'https://logo.clearbit.com/ikea.com', brandColor: Color(0xFF0058A3)),
  CompanyInfo(name: 'Kwantum', logoUrl: 'https://logo.clearbit.com/kwantum.nl', brandColor: Color(0xFF00843D)),
  CompanyInfo(name: 'Jysk', logoUrl: 'https://logo.clearbit.com/jysk.nl', brandColor: Color(0xFF003DA5)),
  CompanyInfo(name: 'Leen Bakker', logoUrl: 'https://logo.clearbit.com/leenbakker.nl', brandColor: Color(0xFFE30613)),
  CompanyInfo(name: 'Xenos', logoUrl: 'https://logo.clearbit.com/xenos.nl', brandColor: Color(0xFFE30613)),
  CompanyInfo(name: 'Blokker', logoUrl: 'https://logo.clearbit.com/blokker.nl', brandColor: Color(0xFFFFCC00)),
  CompanyInfo(name: 'Casa', logoUrl: 'https://logo.clearbit.com/casashops.com', brandColor: Color(0xFF000000)),
  CompanyInfo(name: 'Loods 5', logoUrl: 'https://logo.clearbit.com/loods5.nl', brandColor: Color(0xFF1A1A1A)),
  CompanyInfo(name: 'Swiss Sense', logoUrl: 'https://logo.clearbit.com/swisssense.nl', brandColor: Color(0xFFC8102E)),
  CompanyInfo(name: 'Beter Bed', logoUrl: 'https://logo.clearbit.com/beterbed.nl', brandColor: Color(0xFF003DA5)),

  // === RESTAURANTS / FAST FOOD ===
  CompanyInfo(name: "McDonald's", logoUrl: 'https://logo.clearbit.com/mcdonalds.nl', brandColor: Color(0xFFDA291C)),
  CompanyInfo(name: 'Starbucks', logoUrl: 'https://logo.clearbit.com/starbucks.nl', brandColor: Color(0xFF00704A)),
  CompanyInfo(name: 'Subway', logoUrl: 'https://logo.clearbit.com/subway.com', brandColor: Color(0xFF008C15)),
  CompanyInfo(name: 'Burger King', logoUrl: 'https://logo.clearbit.com/burgerking.nl', brandColor: Color(0xFFD62300)),
  CompanyInfo(name: 'KFC', logoUrl: 'https://logo.clearbit.com/kfc.nl', brandColor: Color(0xFFE4002B)),
  CompanyInfo(name: "Domino's", logoUrl: 'https://logo.clearbit.com/dominos.nl', brandColor: Color(0xFF006491)),
  CompanyInfo(name: 'New York Pizza', logoUrl: 'https://logo.clearbit.com/newyorkpizza.nl', brandColor: Color(0xFFE4002B)),
  CompanyInfo(name: 'La Place', logoUrl: 'https://logo.clearbit.com/laplace.com', brandColor: Color(0xFF5C3D2E)),
  CompanyInfo(name: 'Febo', logoUrl: 'https://logo.clearbit.com/febo.nl', brandColor: Color(0xFFFFCC00)),
  CompanyInfo(name: 'Bakker Bart', logoUrl: 'https://logo.clearbit.com/bakkerbart.nl', brandColor: Color(0xFFE4002B)),

  // === TANKSTATIONS ===
  CompanyInfo(name: 'Shell', logoUrl: 'https://logo.clearbit.com/shell.com', brandColor: Color(0xFFFFCC00)),
  CompanyInfo(name: 'BP', logoUrl: 'https://logo.clearbit.com/bp.com', brandColor: Color(0xFF009900)),
  CompanyInfo(name: 'TotalEnergies', logoUrl: 'https://logo.clearbit.com/totalenergies.com', brandColor: Color(0xFFE4002B)),
  CompanyInfo(name: 'Esso', logoUrl: 'https://logo.clearbit.com/esso.nl', brandColor: Color(0xFF003DA5)),
  CompanyInfo(name: 'Tango', logoUrl: 'https://logo.clearbit.com/tango.nl', brandColor: Color(0xFFFF6600)),
  CompanyInfo(name: 'Tinq', logoUrl: 'https://logo.clearbit.com/tinq.nl', brandColor: Color(0xFF00A550)),

  // === SCHOENEN ===
  CompanyInfo(name: 'vanHaren', logoUrl: 'https://logo.clearbit.com/vanharen.nl', brandColor: Color(0xFF003DA5)),
  CompanyInfo(name: 'Bristol', logoUrl: 'https://logo.clearbit.com/bristol.nl', brandColor: Color(0xFF000000)),
  CompanyInfo(name: 'Sacha', logoUrl: 'https://logo.clearbit.com/sacha.nl', brandColor: Color(0xFF000000)),
  CompanyInfo(name: 'Nelson', logoUrl: 'https://logo.clearbit.com/nelson.nl', brandColor: Color(0xFF000000)),
  CompanyInfo(name: 'Omoda', logoUrl: 'https://logo.clearbit.com/omoda.nl', brandColor: Color(0xFF000000)),

  // === PARFUMERIE / BEAUTY ===
  CompanyInfo(name: 'Douglas', logoUrl: 'https://logo.clearbit.com/douglas.nl', brandColor: Color(0xFF1A1A1A)),
  CompanyInfo(name: 'Rituals', logoUrl: 'https://logo.clearbit.com/rituals.com', brandColor: Color(0xFF000000)),
  CompanyInfo(name: 'ICI Paris XL', logoUrl: 'https://logo.clearbit.com/iciparisxl.nl', brandColor: Color(0xFF000000)),
  CompanyInfo(name: 'Sephora', logoUrl: 'https://logo.clearbit.com/sephora.com', brandColor: Color(0xFF000000)),
  CompanyInfo(name: 'The Body Shop', logoUrl: 'https://logo.clearbit.com/thebodyshop.com', brandColor: Color(0xFF004B28)),
  CompanyInfo(name: 'Lush', logoUrl: 'https://logo.clearbit.com/lush.com', brandColor: Color(0xFF000000)),

  // === ONLINE SHOPS ===
  CompanyInfo(name: 'Bol.com', logoUrl: 'https://logo.clearbit.com/bol.com', brandColor: Color(0xFF0000A4)),
  CompanyInfo(name: 'Wehkamp', logoUrl: 'https://logo.clearbit.com/wehkamp.nl', brandColor: Color(0xFF5C2D91)),
  CompanyInfo(name: 'Zalando', logoUrl: 'https://logo.clearbit.com/zalando.nl', brandColor: Color(0xFFFF6900)),
  CompanyInfo(name: 'Amazon', logoUrl: 'https://logo.clearbit.com/amazon.nl', brandColor: Color(0xFF232F3E)),
  CompanyInfo(name: 'Thuisbezorgd', logoUrl: 'https://logo.clearbit.com/thuisbezorgd.nl', brandColor: Color(0xFFFF8000)),

  // === GEZONDHEID ===
  CompanyInfo(name: 'Holland & Barrett', logoUrl: 'https://logo.clearbit.com/hollandandbarrett.nl', brandColor: Color(0xFF003D2E)),
  CompanyInfo(name: 'Vitaminstore', logoUrl: 'https://logo.clearbit.com/vitaminstore.nl', brandColor: Color(0xFF00A550)),

  // === SPEELGOED ===
  CompanyInfo(name: 'Intertoys', logoUrl: 'https://logo.clearbit.com/intertoys.nl', brandColor: Color(0xFFE4002B)),
  CompanyInfo(name: 'ToyChamp', logoUrl: 'https://logo.clearbit.com/toychamp.nl', brandColor: Color(0xFF003DA5)),

  // === OVERIG NL ===
  CompanyInfo(name: 'Flying Tiger', logoUrl: 'https://logo.clearbit.com/flyingtiger.com', brandColor: Color(0xFFFFCC00)),
  CompanyInfo(name: 'Action', logoUrl: 'https://logo.clearbit.com/action.com', brandColor: Color(0xFF003DA5)),
  CompanyInfo(name: 'ANWB', logoUrl: 'https://logo.clearbit.com/anwb.nl', brandColor: Color(0xFFFFCC00)),
  CompanyInfo(name: 'Pathé', logoUrl: 'https://logo.clearbit.com/pathe.nl', brandColor: Color(0xFF1A1A1A)),
  CompanyInfo(name: 'Kinepolis', logoUrl: 'https://logo.clearbit.com/kinepolis.nl', brandColor: Color(0xFF1A1A1A)),
  CompanyInfo(name: 'Lucardi', logoUrl: 'https://logo.clearbit.com/lucardi.nl', brandColor: Color(0xFF000000)),
  CompanyInfo(name: 'Pearle', logoUrl: 'https://logo.clearbit.com/pearle.nl', brandColor: Color(0xFF003DA5)),
  CompanyInfo(name: 'Specsavers', logoUrl: 'https://logo.clearbit.com/specsavers.nl', brandColor: Color(0xFF00843D)),
  CompanyInfo(name: 'Hans Anders', logoUrl: 'https://logo.clearbit.com/hansanders.nl', brandColor: Color(0xFF003DA5)),
  CompanyInfo(name: 'Prenatal', logoUrl: 'https://logo.clearbit.com/prenatal.nl', brandColor: Color(0xFFE4679A)),
  CompanyInfo(name: 'Normal', logoUrl: 'https://logo.clearbit.com/normal.dk', brandColor: Color(0xFF00C8FF)),
  CompanyInfo(name: 'Big Bazar', logoUrl: 'https://logo.clearbit.com/bigbazar.nl', brandColor: Color(0xFFE30613)),
  CompanyInfo(name: 'Gall & Gall', logoUrl: 'https://logo.clearbit.com/gall.nl', brandColor: Color(0xFF8B0000)),
  CompanyInfo(name: 'Sligro', logoUrl: 'https://logo.clearbit.com/sligro.nl', brandColor: Color(0xFF003DA5)),
  CompanyInfo(name: 'Makro', logoUrl: 'https://logo.clearbit.com/makro.nl', brandColor: Color(0xFF003DA5)),
  CompanyInfo(name: 'Vodafone', logoUrl: 'https://logo.clearbit.com/vodafone.nl', brandColor: Color(0xFFE60000)),
  CompanyInfo(name: 'KPN', logoUrl: 'https://logo.clearbit.com/kpn.com', brandColor: Color(0xFF00843D)),
  CompanyInfo(name: 'T-Mobile', logoUrl: 'https://logo.clearbit.com/t-mobile.nl', brandColor: Color(0xFFE20074)),
  CompanyInfo(name: 'NS', logoUrl: 'https://logo.clearbit.com/ns.nl', brandColor: Color(0xFFFFCC00)),
  CompanyInfo(name: 'KLM', logoUrl: 'https://logo.clearbit.com/klm.com', brandColor: Color(0xFF00A1DE)),
  CompanyInfo(name: 'Booking.com', logoUrl: 'https://logo.clearbit.com/booking.com', brandColor: Color(0xFF003580)),

  // ========================
  // 🇧🇪 BELGIE
  // ========================
  CompanyInfo(name: 'Colruyt', logoUrl: 'https://logo.clearbit.com/colruyt.be', brandColor: Color(0xFF8B0000)),
  CompanyInfo(name: 'Delhaize', logoUrl: 'https://logo.clearbit.com/delhaize.be', brandColor: Color(0xFFE30613)),
  CompanyInfo(name: 'Carrefour', logoUrl: 'https://logo.clearbit.com/carrefour.be', brandColor: Color(0xFF004B93)),
  CompanyInfo(name: 'Proxy Delhaize', logoUrl: 'https://logo.clearbit.com/delhaize.be', brandColor: Color(0xFFE30613)),
  CompanyInfo(name: 'Albert', logoUrl: 'https://logo.clearbit.com/albert.cz', brandColor: Color(0xFFE30613)),
  CompanyInfo(name: 'Fnac', logoUrl: 'https://logo.clearbit.com/fnac.be', brandColor: Color(0xFFE4A81D)),
  CompanyInfo(name: 'Standaard Boekhandel', logoUrl: 'https://logo.clearbit.com/standaardboekhandel.be', brandColor: Color(0xFF003DA5)),
  CompanyInfo(name: 'ZEB', logoUrl: 'https://logo.clearbit.com/zeb.be', brandColor: Color(0xFF000000)),

  // ========================
  // 🇩🇪 DUITSLAND
  // ========================
  CompanyInfo(name: 'dm', logoUrl: 'https://logo.clearbit.com/dm.de', brandColor: Color(0xFF009EE0)),
  CompanyInfo(name: 'Rossmann', logoUrl: 'https://logo.clearbit.com/rossmann.de', brandColor: Color(0xFFE30613)),
  CompanyInfo(name: 'Müller', logoUrl: 'https://logo.clearbit.com/mueller.de', brandColor: Color(0xFFE30613)),
  CompanyInfo(name: 'REWE', logoUrl: 'https://logo.clearbit.com/rewe.de', brandColor: Color(0xFFCC071E)),
  CompanyInfo(name: 'Edeka', logoUrl: 'https://logo.clearbit.com/edeka.de', brandColor: Color(0xFF004B93)),
  CompanyInfo(name: 'Kaufland', logoUrl: 'https://logo.clearbit.com/kaufland.de', brandColor: Color(0xFFE30613)),
  CompanyInfo(name: 'Penny', logoUrl: 'https://logo.clearbit.com/penny.de', brandColor: Color(0xFFCC0000)),
  CompanyInfo(name: 'Netto', logoUrl: 'https://logo.clearbit.com/netto.de', brandColor: Color(0xFFFFCC00)),
  CompanyInfo(name: 'Saturn', logoUrl: 'https://logo.clearbit.com/saturn.de', brandColor: Color(0xFFFF6600)),
  CompanyInfo(name: 'Tchibo', logoUrl: 'https://logo.clearbit.com/tchibo.de', brandColor: Color(0xFF003DA5)),
  CompanyInfo(name: 'Deichmann', logoUrl: 'https://logo.clearbit.com/deichmann.de', brandColor: Color(0xFFE30613)),
  CompanyInfo(name: 'Thalia', logoUrl: 'https://logo.clearbit.com/thalia.de', brandColor: Color(0xFF4A90D9)),
  CompanyInfo(name: 'OBI', logoUrl: 'https://logo.clearbit.com/obi.de', brandColor: Color(0xFFFF6600)),
  CompanyInfo(name: 'Bauhaus', logoUrl: 'https://logo.clearbit.com/bauhaus.info', brandColor: Color(0xFFE30613)),
  CompanyInfo(name: 'toom', logoUrl: 'https://logo.clearbit.com/toom.de', brandColor: Color(0xFFE30613)),

  // ========================
  // 🇫🇷 FRANKRIJK
  // ========================
  CompanyInfo(name: 'Leclerc', logoUrl: 'https://logo.clearbit.com/e.leclerc', brandColor: Color(0xFF003DA5)),
  CompanyInfo(name: 'Auchan', logoUrl: 'https://logo.clearbit.com/auchan.fr', brandColor: Color(0xFFE30613)),
  CompanyInfo(name: 'Intermarché', logoUrl: 'https://logo.clearbit.com/intermarche.com', brandColor: Color(0xFFE30613)),
  CompanyInfo(name: 'Casino', logoUrl: 'https://logo.clearbit.com/groupe-casino.fr', brandColor: Color(0xFFE30613)),
  CompanyInfo(name: 'Monoprix', logoUrl: 'https://logo.clearbit.com/monoprix.fr', brandColor: Color(0xFFE30613)),
  CompanyInfo(name: 'Picard', logoUrl: 'https://logo.clearbit.com/picard.fr', brandColor: Color(0xFF003082)),
  CompanyInfo(name: 'Yves Rocher', logoUrl: 'https://logo.clearbit.com/yves-rocher.com', brandColor: Color(0xFF00843D)),
  CompanyInfo(name: 'Boulanger', logoUrl: 'https://logo.clearbit.com/boulanger.com', brandColor: Color(0xFF003DA5)),

  // ========================
  // 🇬🇧 VERENIGD KONINKRIJK
  // ========================
  CompanyInfo(name: 'Tesco', logoUrl: 'https://logo.clearbit.com/tesco.com', brandColor: Color(0xFF003DA5)),
  CompanyInfo(name: 'Sainsburys', logoUrl: 'https://logo.clearbit.com/sainsburys.co.uk', brandColor: Color(0xFFFF6600)),
  CompanyInfo(name: 'Boots', logoUrl: 'https://logo.clearbit.com/boots.com', brandColor: Color(0xFF003DA5)),
  CompanyInfo(name: 'Superdrug', logoUrl: 'https://logo.clearbit.com/superdrug.com', brandColor: Color(0xFF003DA5)),
  CompanyInfo(name: 'Waitrose', logoUrl: 'https://logo.clearbit.com/waitrose.com', brandColor: Color(0xFF00843D)),
  CompanyInfo(name: 'Marks & Spencer', logoUrl: 'https://logo.clearbit.com/marksandspencer.com', brandColor: Color(0xFF000000)),
  CompanyInfo(name: 'John Lewis', logoUrl: 'https://logo.clearbit.com/johnlewis.com', brandColor: Color(0xFF003D2E)),
  CompanyInfo(name: 'Argos', logoUrl: 'https://logo.clearbit.com/argos.co.uk', brandColor: Color(0xFFE4002B)),
  CompanyInfo(name: 'Nandos', logoUrl: 'https://logo.clearbit.com/nandos.co.uk', brandColor: Color(0xFF000000)),
  CompanyInfo(name: 'Costa Coffee', logoUrl: 'https://logo.clearbit.com/costa.co.uk', brandColor: Color(0xFF6B0034)),
  CompanyInfo(name: 'Greggs', logoUrl: 'https://logo.clearbit.com/greggs.co.uk', brandColor: Color(0xFF003DA5)),
  CompanyInfo(name: 'WHSmith', logoUrl: 'https://logo.clearbit.com/whsmith.co.uk', brandColor: Color(0xFF5C2D91)),
  CompanyInfo(name: 'Superdry', logoUrl: 'https://logo.clearbit.com/superdry.com', brandColor: Color(0xFFFF6600)),
  CompanyInfo(name: 'Next', logoUrl: 'https://logo.clearbit.com/next.co.uk', brandColor: Color(0xFF000000)),
  CompanyInfo(name: 'River Island', logoUrl: 'https://logo.clearbit.com/riverisland.com', brandColor: Color(0xFF000000)),
  CompanyInfo(name: 'New Look', logoUrl: 'https://logo.clearbit.com/newlook.com', brandColor: Color(0xFF000000)),

  // ========================
  // 🇺🇸 VERENIGDE STATEN
  // ========================
  CompanyInfo(name: 'Walmart', logoUrl: 'https://logo.clearbit.com/walmart.com', brandColor: Color(0xFF0071CE)),
  CompanyInfo(name: 'Target', logoUrl: 'https://logo.clearbit.com/target.com', brandColor: Color(0xFFCC0000)),
  CompanyInfo(name: 'Costco', logoUrl: 'https://logo.clearbit.com/costco.com', brandColor: Color(0xFFE31837)),
  CompanyInfo(name: 'Walgreens', logoUrl: 'https://logo.clearbit.com/walgreens.com', brandColor: Color(0xFFE31837)),
  CompanyInfo(name: 'CVS', logoUrl: 'https://logo.clearbit.com/cvs.com', brandColor: Color(0xFFCC0000)),
  CompanyInfo(name: 'Home Depot', logoUrl: 'https://logo.clearbit.com/homedepot.com', brandColor: Color(0xFFF96302)),
  CompanyInfo(name: 'Lowes', logoUrl: 'https://logo.clearbit.com/lowes.com', brandColor: Color(0xFF004990)),
  CompanyInfo(name: 'Best Buy', logoUrl: 'https://logo.clearbit.com/bestbuy.com', brandColor: Color(0xFF0046BE)),
  CompanyInfo(name: 'Sephora US', logoUrl: 'https://logo.clearbit.com/sephora.com', brandColor: Color(0xFF000000)),
  CompanyInfo(name: 'Bath & Body Works', logoUrl: 'https://logo.clearbit.com/bathandbodyworks.com', brandColor: Color(0xFF003DA5)),
  CompanyInfo(name: 'Nordstrom', logoUrl: 'https://logo.clearbit.com/nordstrom.com', brandColor: Color(0xFF000000)),
  CompanyInfo(name: 'Macy\'s', logoUrl: 'https://logo.clearbit.com/macys.com', brandColor: Color(0xFFE21A2C)),
  CompanyInfo(name: 'Gap', logoUrl: 'https://logo.clearbit.com/gap.com', brandColor: Color(0xFF000068)),
  CompanyInfo(name: 'Old Navy', logoUrl: 'https://logo.clearbit.com/oldnavy.com', brandColor: Color(0xFF003DA5)),
  CompanyInfo(name: 'Victoria\'s Secret', logoUrl: 'https://logo.clearbit.com/victoriassecret.com', brandColor: Color(0xFFE4007C)),
  CompanyInfo(name: 'Ulta Beauty', logoUrl: 'https://logo.clearbit.com/ulta.com', brandColor: Color(0xFFE4002B)),
  CompanyInfo(name: 'Panera Bread', logoUrl: 'https://logo.clearbit.com/panerabread.com', brandColor: Color(0xFF4A7729)),
  CompanyInfo(name: 'Chick-fil-A', logoUrl: 'https://logo.clearbit.com/chick-fil-a.com', brandColor: Color(0xFFE51636)),
  CompanyInfo(name: 'Chipotle', logoUrl: 'https://logo.clearbit.com/chipotle.com', brandColor: Color(0xFF441500)),
  CompanyInfo(name: 'Dunkin', logoUrl: 'https://logo.clearbit.com/dunkindonuts.com', brandColor: Color(0xFFFF671F)),

  // ========================
  // 🌍 INTERNATIONAAL
  // ========================
  CompanyInfo(name: 'Apple', logoUrl: 'https://logo.clearbit.com/apple.com', brandColor: Color(0xFF000000)),
  CompanyInfo(name: 'Samsung', logoUrl: 'https://logo.clearbit.com/samsung.com', brandColor: Color(0xFF1428A0)),
  CompanyInfo(name: 'Spotify', logoUrl: 'https://logo.clearbit.com/spotify.com', brandColor: Color(0xFF1DB954)),
  CompanyInfo(name: 'Netflix', logoUrl: 'https://logo.clearbit.com/netflix.com', brandColor: Color(0xFFE50914)),
  CompanyInfo(name: 'LEGO', logoUrl: 'https://logo.clearbit.com/lego.com', brandColor: Color(0xFFFFCC00)),
  CompanyInfo(name: 'Dyson', logoUrl: 'https://logo.clearbit.com/dyson.com', brandColor: Color(0xFF5C2D91)),
];

CompanyInfo? findCompany(String name) {
  final lower = name.toLowerCase();
  try {
    return knownCompanies.firstWhere(
      (c) => c.name.toLowerCase() == lower,
    );
  } catch (_) {
    return null;
  }
}

List<CompanyInfo> searchCompanies(String query) {
  if (query.isEmpty) return knownCompanies;
  final lower = query.toLowerCase();
  return knownCompanies
      .where((c) => c.name.toLowerCase().contains(lower))
      .toList();
}
