import 'package:flutter_destroyer/models/soulLand/technique/base.dart';

class GhostShadowPerplexingTrack extends BaseTechnique {
  GhostShadowPerplexingTrack({
    super.id = 3,
    super.name = "Quỷ Ảnh Mê Tung",
    super.multiplier = 0.35,
    super.multiplierOrigin = 0.35,
  });

  GhostShadowPerplexingTrack.fromMap(Map<String, dynamic> map) {
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

    multiplier = 0.35;
    multiplierOrigin = 0.35;
  }
}
