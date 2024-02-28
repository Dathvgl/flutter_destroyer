import 'dart:math';

class BaseTechnique {
  int id = -1;
  String name = "";

  double multiplier = 0.0;
  double multiplierOrigin = 0.0;

  String realm = "Cấp 1";
  double enlightenment = 0.0;

  int level = 1;
  int exp = 0;
  int expOrigin = 10;
  bool isLevel = true;

  BaseTechnique({
    this.id = -1,
    this.name = "",
    this.multiplier = 0.0,
    this.multiplierOrigin = 0.0,
    this.realm = "Cấp 1",
    this.enlightenment = 0.0,
    this.level = 0,
    this.exp = 10,
    this.expOrigin = 10,
    this.isLevel = true,
  });

  factory BaseTechnique.cloneWith(BaseTechnique clone) {
    return BaseTechnique(
      id: clone.id,
      name: clone.name,
      multiplier: clone.multiplier,
      multiplierOrigin: clone.multiplierOrigin,
      realm: clone.realm,
      enlightenment: clone.enlightenment,
      level: clone.level,
      exp: clone.exp,
      expOrigin: clone.expOrigin,
      isLevel: clone.isLevel,
    );
  }

  BaseTechnique.fromMap(Map<String, dynamic> map) {
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "multiplier": multiplier,
      "multiplierOrigin": multiplierOrigin,
      "realm": realm,
      "enlightenment": enlightenment,
      "level": level,
      "exp": exp,
      "expOrigin": expOrigin,
      "isLevel": isLevel ? 1 : 0,
    };
  }

  void realming({
    required num expNew,
    Map<String, dynamic> map = const {},
  }) {
    final lv = level + 1;
    enlightenment -= exp;

    level++;
    multiplier = multiplierOrigin + multiplierOrigin * lv;
    realm == "Cấp $lv";

    double newExp = expOrigin * lv * multiplierOrigin;
    exp = expOrigin + (newExp * log(lv + expNew)).round();
  }

  bool isExp() {
    return enlightenment >= exp.toDouble();
  }

  void reset() {
    level = 1;
    exp = 0;
    expOrigin = 10;
  }
}
