import 'package:flutter_destroyer/models/soulLand/technique/base.dart';

class ControllingCraneCatchingDragon extends BaseTechnique {
  ControllingCraneCatchingDragon({
    super.id = 4,
    super.name = "Khống Hạc Cầm Long",
    super.multiplier = 0.275,
    super.multiplierOrigin = 0.275,
  });

  ControllingCraneCatchingDragon.fromMap(Map<String, dynamic> map) {
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

    multiplier = 0.275;
    multiplierOrigin = 0.275;
  }
}
