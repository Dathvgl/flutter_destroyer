import 'package:flutter/material.dart';
import 'package:flutter_destroyer/components/function.dart';

class SpiritSoul {
  String name = "";
  double multiplier = 0.0;

  int level = 0;
  int year = 0;

  bool isYear = false;

  double energy = 0.0;
  final int energyBase = 10;

  // Xám - Trắng - Vàng - Tím - Đen - Đỏ - Thần sắc
  static final nameCap = [
    "Không Năm Hồn Hoàn",
    "Mười Năm Hồn Hoàn",
    "Trăm Năm Hồn Hoàn",
    "Nghìn Năm Hồn Hoàn",
    "Vạn Năm Hồn Hoàn",
    "Mười Vạn Năm Hồn Hoàn",
    "Trăm Vạn Năm Hồn Hoàn",
  ];

  static final yearCap = [
    0,
    10,
    100,
    1000,
    10000,
    100000,
    1000000,
  ];

  static final imageCap = [
    "assets/images/honHoan/Picture1.png",
    "assets/images/honHoan/Picture2.png",
    "assets/images/honHoan/Picture3.png",
    "assets/images/honHoan/Picture4.png",
    "assets/images/honHoan/Picture5.png",
    "assets/images/honHoan/Picture6.png",
    "assets/images/honHoan/Picture7.png",
  ];

  static final colorCap = [
    const Color(0xffa6a6a6),
    const Color(0xffffffff),
    const Color(0xffffe699),
    const Color(0xff8926ec),
    const Color(0xff000000),
    const Color(0xffc00000),
    const Color(0xffffffff),
  ];

  static final multipliers = [
    2.0,
    5.0,
    12.0,
    30.0,
    55.0,
    200.0,
    220.0,
  ];

  static final rank = [
    "Nhất",
    "Nhị",
    "Tam",
    "Tứ",
    "Ngũ",
    "Lục",
    "Thất",
    "Bát",
    "Cửu",
    "Thập",
  ];

  SpiritSoul({
    required this.name,
    required this.multiplier,
    this.level = 0,
    this.year = 0,
    this.isYear = false,
    this.energy = 0.0,
  });

  factory SpiritSoul.cloneWith(SpiritSoul clone) {
    return SpiritSoul(
      name: clone.name,
      multiplier: clone.multiplier,
      level: clone.level,
      year: clone.year,
      isYear: clone.isYear,
      energy: clone.energy,
    );
  }

  SpiritSoul.fromMap(Map<String, dynamic> map) {
    level = map["level"] as int;
    name = map["name"] as String;
    year = map["year"] as int;
    multiplier = map["multiplier"] as double;
    isYear = map["isYear"] as int == 1 ? true : false;
    energy = map["energy"] as double;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "level": level,
      "name": name,
      "year": year,
      "multiplier": multiplier,
      "isYear": isYear ? 1 : 0,
      "energy": energy,
    };
  }

  int expInfo() {
    if (level <= 0) {
      return energyBase;
    }

    if (level + 1 >= yearCap.length) {
      return (energyBase * yearCap.last * (log10(year) / level) / level)
          .round();
    }

    return (energyBase * yearCap[level] * (log10(year) / level) / level)
        .round();
  }

  bool isName() {
    if (level + 1 >= yearCap.length) {
      return false;
    }

    return year != 0 && year == yearCap[level + 1];
  }
}
