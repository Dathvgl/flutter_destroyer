import 'dart:math';

import 'package:flutter_destroyer/models/soulland/spiritual_power.dart';
import 'package:flutter_destroyer/models/soulLand/technique/base.dart';

class PurpleDemonEyes extends BaseTechnique {
  static const int unique = 2;

  final nameCap = [
    "Tung Quan",
    "Nhập Vi",
    "Giới Tử",
    "Hạo Hãn",
  ];

  final multipliers = [
    30.0,
    25.0,
    22.5,
    20.0,
  ];

  PurpleDemonEyes({
    super.id = 2,
    super.name = "Tử Cực Ma Đồng",
    super.realm = "Tung Quan",
  }) {
    this.exp = 0;
    isLevel = false;
  }

  PurpleDemonEyes.fromMap(Map<String, dynamic> map) {
    id = map["id"] as int;
    name = map["name"] as String;
    multiplier = map["multiplier"] as double;
    multiplierOrigin = map["multiplierOrigin"] as double;
    realm = map["realm"] as String;
    level = map["level"] as int;
    this.exp = map["exp"] as int;
    isLevel = map["isLevel"] as int == 1 ? true : false;
  }

  @override
  void realming({
    required num expNew,
    Map<String, dynamic> map = const {},
  }) {
    final spiritualPowerLevel = map["spiritualPowerLevel"] as int;

    if (expNew <= 1) {
      multiplierOrigin = multipliers.first;

      double pw = pow(expNew, 1 / multiplierOrigin).toDouble();
      multiplier = pw * expNew;

      realm = nameCap.first;
      return;
    }

    if (expNew >= SpiritualPower.expCap.last || spiritualPowerLevel > 4) {
      level = 3;
      if (this.exp < level) {
        this.exp = 3;
        multiplierOrigin = multipliers.last;

        double pw = pow(expNew, 1 / multiplierOrigin).toDouble();
        multiplier = pw * expNew;

        realm = nameCap.last;
      }
      return;
    }

    if (spiritualPowerLevel >= nameCap.length) {
      return;
    }

    if (spiritualPowerLevel == 1 || spiritualPowerLevel == 2) {
      level = 1;
      if (this.exp < level) {
        this.exp = 1;
        multiplierOrigin = multipliers[this.exp];

        double pw = pow(expNew, 1 / multiplierOrigin).toDouble();
        multiplier = pw * expNew;

        realm = nameCap[this.exp];
      }
      return;
    }

    if (spiritualPowerLevel == 3 || spiritualPowerLevel == 4) {
      level = 2;
      if (this.exp < level) {
        this.exp = 2;
        multiplierOrigin = multipliers[this.exp];

        double pw = pow(expNew, 1 / multiplierOrigin).toDouble();
        multiplier = pw * expNew;

        realm = nameCap[this.exp];
      }
    }
  }
}
