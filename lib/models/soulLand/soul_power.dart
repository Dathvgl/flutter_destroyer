import 'package:flutter_destroyer/components/function.dart';

class SoulPower {
  final int id = 0;

  int rank = 0; // Cấp hồn lực
  double energy = 0; // Kinh nghiệm

  int level = 0; // Cấp trong kinh nghiệm mỗi bậc

  bool breakThrough = false; // Điều kiện nhận hồn hoàn
  bool limitBreak = false; // Điều kiện sau khi nhận hồn hoàn

  static final nameCap = [
    "Hồn Sĩ",
    "Hồn Sư",
    "Hồn Đại Sư",
    "Hồn Tôn",
    "Hồn Tông",
    "Hồn Vương",
    "Hồn Đế",
    "Hồn Thánh",
    "Hồn Đấu La",
    "Phong Hào Đấu La",
    "Thần Đấu La",
  ];

  static final levelCap = [
    1,
    11,
    21,
    31,
    41,
    51,
    61,
    71,
    81,
    91,
    100,
  ];

  final expCap = [
    100, // Hồn Sĩ -> Hồn Sư
    1000, // Hồn Sư -> Hồn Đại Sư
    10000, // Hồn Đại Sư -> Hồn Tôn
    100000, // Hồn Tôn -> Hồng Tông
    1000000, // Hồn Tông -> Hồn Vương
    10000000, // Hồn Vương -> Hồn Đế
    100000000, // Hồn Đế => Hồn Thánh
    1000000000, // Hồn Thánh -> Hồn Đấu La
    10000000000, // Hồn Đấu la -> Phong Hào Đấu La
    100000000000, // Phong Hào Đấu la -> Thần Đấu La
  ];

  SoulPower({
    this.rank = 0,
    this.energy = 0,
    this.level = 0,
    this.breakThrough = false,
    this.limitBreak = false,
  });

  factory SoulPower.cloneWith(SoulPower clone) {
    return SoulPower(
      rank: clone.rank,
      energy: clone.energy,
      level: clone.level,
      breakThrough: clone.breakThrough,
      limitBreak: clone.limitBreak,
    );
  }

  SoulPower.fromMap(Map<String, dynamic> map) {
    rank = map["rank"] as int;
    energy = map["exp"] as double;
    level = map["level"] as int;
    breakThrough = map["breakThrough"] as int == 1 ? true : false;
    limitBreak = map["limitBreak"] as int == 1 ? true : false;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "rank": rank,
      "exp": energy,
      "level": level,
      "breakThrough": breakThrough ? 1 : 0,
      "limitBreak": limitBreak ? 1 : 0,
    };
  }

  int expInfo() {
    return expCap[level];
  }

  bool isName() {
    if (level + 1 >= expCap.length) {
      return false;
    }

    return rank != 0 && intNotDecimal(rank / 10) && !limitBreak;
  }

  bool isExp() {
    return energy >= expCap[level].toDouble();
  }

  String leveling() {
    if (rank <= 0) {
      return "Không hồn lực";
    }

    if (rank >= levelCap.last) {
      return nameCap.last;
    }

    if (level + 1 >= levelCap.length) {
      return nameCap[level];
    }

    if (rank != levelCap[level + 1]) {
      return nameCap[level];
    }

    if (rank != levelCap.first) {
      level++;
    }

    return nameCap[level];
  }

  void reset() {
    rank = 0;
    energy = 0.0;
    level = 0;
    breakThrough = false;
    limitBreak = false;
  }
}
