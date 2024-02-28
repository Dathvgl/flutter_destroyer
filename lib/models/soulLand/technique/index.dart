import 'dart:convert';

import 'package:flutter_destroyer/models/soulLand/technique/base.dart';
import 'package:flutter_destroyer/models/soulLand/technique/controlling_crane_catching_dragon.dart';
import 'package:flutter_destroyer/models/soulLand/technique/ghost_shadow_perplexing_track.dart';
import 'package:flutter_destroyer/models/soulLand/technique/mysterious_heaven_technique.dart';
import 'package:flutter_destroyer/models/soulLand/technique/mysterious_jade_hand.dart';
import 'package:flutter_destroyer/models/soulLand/technique/purple_demon_eyes.dart';

class Technique {
  final int id = 2;
  final String name = "Huyền Thiên Bảo Lục";

  double energy = 0.0;
  int share = 0;

  double multiplier = 0.0;

  List<BaseTechnique> tangSectTechniques = const [];

  Technique({
    this.energy = 0.0,
    this.share = 0,
    this.multiplier = 0.0,
    List<BaseTechnique>? list,
  }) {
    List<BaseTechnique> base = [
      MysteriousHeavenTechnique(), // Huyền thiên công
      MysteriousJadeHand(), // Huyền ngọc thủ
      PurpleDemonEyes(), // Tử cực ma đồng
      GhostShadowPerplexingTrack(), // Quỷ ảnh mê tung
      ControllingCraneCatchingDragon(), // Khống hạc cầm long
    ];

    tangSectTechniques = list ?? base;
    share = tangSectTechniques.length;

    for (var item in tangSectTechniques) {
      if (!item.isLevel) {
        share--;
      }
    }

    multiplierAlt();
  }

  factory Technique.cloneWith(Technique clone) {
    return Technique(
      energy: clone.energy,
      share: clone.share,
      multiplier: clone.multiplier,
      list: clone.tangSectTechniques.map((item) {
        return BaseTechnique.cloneWith(item);
      }).toList(),
    );
  }

  Technique.fromMap(Map<String, dynamic> map) {
    energy = map["energy"];
    share = map["share"];
    multiplier = map["multiplier"];
    tangSectTechniques = mapList(map["tangSectTechniques"]);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "energy": energy,
      "share": share,
      "multiplier": multiplier,
      "tangSectTechniques": jsonEncode(
        tangSectTechniques
            .map((x) => jsonEncode(
                  x.toMap(),
                ).toString())
            .toList(),
      ).toString(),
    };
  }

  List<BaseTechnique> mapList(String str) {
    List<BaseTechnique> list = [];

    Iterable map = jsonDecode(str);
    final int n = map.length;

    for (var i = 0; i < n; i++) {
      final item = jsonDecode(map.elementAt(i));
      list.add(mapCongPhap(i, item));
    }
    return list;
  }

  BaseTechnique mapCongPhap(int index, Map<String, dynamic> map) {
    switch (index) {
      case 0:
        return MysteriousHeavenTechnique.fromMap(map);
      case 1:
        return MysteriousJadeHand.fromMap(map);
      case 2:
        return PurpleDemonEyes.fromMap(map);
      case 3:
        return GhostShadowPerplexingTrack.fromMap(map);
      case 4:
        return ControllingCraneCatchingDragon.fromMap(map);
      default:
        return BaseTechnique();
    }
  }

  void multiplierAlt() {
    multiplier = 0.0;

    for (var item in tangSectTechniques) {
      if (item.id == MysteriousHeavenTechnique.unique) {
        continue;
      }

      multiplier += item.multiplier;
    }
  }

  double shareEnergy() {
    if (share <= 0) {
      return 0.0;
    }

    return energy / share;
  }

  void reset() {
    energy = 0.0;

    for (var item in tangSectTechniques) {
      item.reset();
    }

    multiplierAlt();
  }
}
