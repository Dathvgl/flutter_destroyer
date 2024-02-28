import 'package:flutter_destroyer/models/soulLand/martialSoul/spirit/beast_spirit.dart';
import 'package:flutter_destroyer/models/soulLand/martialSoul/spirit/tool_spirit.dart';

class MartialSoul {
  String name = "";
  double multiplier = 0.0;

  int level = 0;
  String quality = "Phẩm Võ Hồn";

  static final spirits = [
    ToolSpirit(),
    BeastSpirit(),
  ];

  static final rank = [
    "Nhất", // Khởi đầu
    "Nhị", // Hồn tôn
    "Tam", // 3 hh trăm năm và 3 cp trên cấp 100
    "Tứ", // Hồn tông, 3 cp trên cấp 500 và linh hải cảnh
    "Ngũ", // Hồn vương và 4 hh nghìn năm
    "Lục", // Hồn đế, 4 hh vạn năm và linh uyên cảnh
    "Thất", // Hồn thánh, 7 hh vạn năm và 3 cp trên cấp 5000
    "Bát", // Hồn đấu la, 1 hh 10 vạn năm và linh vực cảnh
    "Cửu", // Siêu cấp đấu la, 6 hh 10 vạn năm và 3 cp trên vạn cấp
    "Thập", // Cực hạn đấu la, 9 hh 10 vạn năm, thần nguyên cảnh và 3 cp trên 10 vạn cấp
  ];

  static final multipliers = [
    1.0,
    5.0,
    7.0,
    10.0,
    15.0,
    20.0,
    25.0,
    30.0,
    35.0,
    40.0,
  ];

  MartialSoul({
    this.name = "",
    this.multiplier = 0.0,
    this.level = 0,
    this.quality = "Phẩm Võ Hồn",
  });

  factory MartialSoul.cloneWith(MartialSoul clone) {
    return MartialSoul(
      name: clone.name,
      multiplier: clone.multiplier,
      level: clone.level,
      quality: clone.quality,
    );
  }

  MartialSoul.fromMap(Map<String, dynamic> map) {
    name = map["name"] as String;
    multiplier = map["multiplier"] as double;
    level = map["level"] as int;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "name": name,
      "multiplier": multiplier,
      "level": level,
    };
  }

  void reset() {
    name = "";
    multiplier = 0.0;
    level = 0;
  }
}
