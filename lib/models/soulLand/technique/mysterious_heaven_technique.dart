import 'package:flutter_destroyer/models/soulland/soul_power.dart';
import 'package:flutter_destroyer/models/soulLand/technique/base.dart';

class MysteriousHeavenTechnique extends BaseTechnique {
  static const int unique = 0;

  final tangLinhNgo = [
    "Nhập môn",
    "Tầng thứ 1",
    "Tầng thứ 2",
    "Tầng thứ 3",
    "Tầng thứ 4",
    "Tầng thứ 5",
    "Tầng thứ 6",
    "Tầng thứ 7",
    "Tầng thứ 8",
    "Tầng thứ 9",
    "Tầng thứ 10",
  ];

  final tangHeSo = [
    1.0,
    2.5,
    5.0,
    7.5,
    10.0,
    12.5,
    15.0,
    17.5,
    20.0,
    22.5,
    25.0,
  ];

  MysteriousHeavenTechnique({
    super.id = 0,
    super.name = "Huyền Thiên Công",
    super.realm = "Nhập môn",
  }) {
    level = 0;
    isLevel = false;
  }

  MysteriousHeavenTechnique.fromMap(Map<String, dynamic> map) {
    id = map["id"] as int;
    name = map["name"] as String;
    multiplier = map["multiplier"] as double;
    realm = map["realm"] as String;
    level = map["level"] as int;
    isLevel = map["isLevel"] as int == 1 ? true : false;
  }

  @override
  void realming({
    required num expNew,
    Map<String, dynamic> map = const {},
  }) {
    if (expNew <= 0) {
      multiplier = tangHeSo.first;
      realm = tangLinhNgo.first;
      return;
    }

    if (expNew >= SoulPower.levelCap.last) {
      multiplier = tangHeSo.last;
      realm = tangLinhNgo.last;
      return;
    }

    if (level + 1 >= tangLinhNgo.length) {
      return;
    }

    if (expNew < SoulPower.levelCap[level + 1]) {
      return;
    }

    level++;
    multiplier = tangHeSo[level];
    realm = tangLinhNgo[level];
  }

  @override
  void reset() {
    super.reset();

    level = 0;
  }
}
