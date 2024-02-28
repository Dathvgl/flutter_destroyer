import 'dart:convert';

import 'package:flutter_destroyer/models/soulLand/soulRing/spirit_soul.dart';

class SoulRing {
  final int id = 3;
  double multiplier = 0.0;

  List<SpiritSoul> spiritSouls = [];

  SoulRing({
    this.multiplier = 0.0,
    this.spiritSouls = const [],
  });

  factory SoulRing.cloneWith(SoulRing clone) {
    return SoulRing(
      multiplier: clone.multiplier,
      spiritSouls: clone.spiritSouls.map((item) {
        return SpiritSoul.cloneWith(item);
      }).toList(),
    );
  }

  SoulRing.fromMap(Map<String, dynamic> map) {
    multiplier = map["multiplier"] as double;
    spiritSouls = mapList(map["spiritSouls"]) as List<SpiritSoul>;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "multiplier": multiplier,
      "spiritSouls": jsonEncode(
        spiritSouls
            .map((x) => jsonEncode(
                  x.toMap(),
                ).toString())
            .toList(),
      ).toString(),
    };
  }

  List mapList(String str) {
    Iterable list = jsonDecode(str);
    return list
        .map((x) => SpiritSoul.fromMap(
              jsonDecode(x),
            ))
        .toList();
  }

  void soulTemp() {
    int index = spiritSouls.length;

    if (spiritSouls.length >= 10) {
      return;
    }

    multiplier += SpiritSoul.multipliers.first;
    spiritSouls.add(SpiritSoul(
      name: "${SpiritSoul.rank[index]} Hồn Hoàn",
      multiplier: SpiritSoul.multipliers.first,
    ));
  }

  void energyTemp(double energy) {
    if (spiritSouls.isEmpty) {
      return;
    }

    int quantity =
        spiritSouls.where((element) => element.isYear == true).length;

    if (quantity == 0) {
      return;
    }

    double enlightenment = energy / quantity;
    for (var item in spiritSouls) {
      if (!item.isYear) {
        continue;
      }

      item.energy += enlightenment;
    }
  }

  void reset() {
    multiplier = 0.0;
    spiritSouls.clear();
  }
}
