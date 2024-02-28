import 'package:flutter/material.dart';

class SpiritualPower {
  final int id = 1;

  int spiritual = 1;
  double energy = 0;

  int level = 0;

  // Bạch - Hoàng - Tử - Hắc - Hồng - Chanh - Kim
  static final nameCap = [
    "Linh Nguyên Cảnh", // Hồn sĩ - hồn sư
    "Linh Thông Cảnh", // Hồn đại sư - hồn tôn
    "Linh Hải Cảnh", // Hồn tông - hồn vương
    "Linh Uyên Cảnh", // Hồn đế - hồn thánh
    "Linh Vực Cảnh", // Hồn đấu la - Phong hào đấu la
    "Thần Nguyên Cảnh", // Thần đấu la
    "Thần Vương Cảnh", // ???
  ];

  static final levelCap = [
    1, // Tung quan
    100, // Nhập vi
    500, // Nhập vi
    5000, // Giới tử
    20000, // Giới tử
    50000, // Hạo hãn
    100000, // Hạo hãn ???
  ];

  static final colorCap = [
    Colors.white,
    Colors.amber,
    Colors.purple.shade700,
    Colors.black,
    Colors.pink.shade300,
    Colors.lime,
    Colors.yellow.shade300,
  ];

  static final expCap = [
    100,
    10000,
    1000000,
    100000000,
    10000000000,
    1000000000000,
    100000000000000,
  ];

  SpiritualPower({
    this.spiritual = 1,
    this.energy = 0,
    this.level = 0,
  });

  factory SpiritualPower.cloneWith(SpiritualPower clone) {
    return SpiritualPower(
      spiritual: clone.spiritual,
      energy: clone.energy,
      level: clone.level,
    );
  }

  SpiritualPower.fromMap(Map<String, dynamic> map) {
    spiritual = map["spiritual"] as int;
    energy = map["energy"] as double;
    level = map["level"] as int;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "spiritual": spiritual,
      "energy": energy,
      "level": level,
    };
  }

  int expInfo() {
    return expCap[level];
  }

  bool isName() {
    if (level + 1 >= expCap.length) {
      return false;
    }

    return spiritual != 1 && spiritual == levelCap[level];
  }

  bool isExp() {
    return energy >= expCap[level].toDouble();
  }

  String leveling(int tinhthanluc) {
    if (tinhthanluc >= levelCap.last) {
      return nameCap.last;
    }

    if (level + 1 >= levelCap.length) {
      return nameCap[level];
    }

    if (tinhthanluc != levelCap[level + 1]) {
      return nameCap[level];
    }

    if (tinhthanluc != levelCap.first) {
      level++;
    }

    return nameCap[level];
  }

  void reset() {
    spiritual = 1;
    energy = 0.0;
    level = 0;
  }
}
