import 'package:flutter_destroyer/models/soulLand/technique/base.dart';

class MysteriousJadeHand extends BaseTechnique {
  MysteriousJadeHand({
    super.id = 1,
    super.name = "Huyền Ngọc Thủ",
    super.multiplier = 0.2,
    super.multiplierOrigin = 0.2,
  });

  MysteriousJadeHand.fromMap(Map<String, dynamic> map) {
    id = map["id"] as int;
    name = map["name"] as String;
    multiplier = map["multiplier"] as double;
    multiplierOrigin = map["multiplierOrigin"] as double;
    realm = map["realm"] as String;
    enlightenment = map["enlightenment"] as double;
    level = map["level"] as int;
    exp = map["exp"] as int;
    expOrigin = map["expOrigin"] as int;
    isLevel = map["isLevel"] as int == 1 ? true : false;
  }

  @override
  void reset() {
    super.reset();

    multiplier = 0.2;
    multiplierOrigin = 0.2;
  }
}
