import 'package:flutter/material.dart';
import 'package:flutter_destroyer/components/interface.dart';

class TinhThanLuc implements JsonMap, DauLaChung {
  final int id = 1;

  int tinhthanluc = 1;
  double honkhi = 0;

  static int capdo = 0;

  // Bạch - Hoàng - Tử - Hắc - Hồng - Chanh - Kim
  static final honsu = [
    'Linh Nguyên Cảnh', // Hồn sĩ - hồn sư
    'Linh Thông Cảnh', // Hồn đại sư - hồn tôn
    'Linh Hải Cảnh', // Hồn tông - hồn vương
    'Linh Uyên Cảnh', // Hồn đế - hồn thánh
    'Linh Vực Cảnh', // Hồn đấu la - Phong hào đấu la
    'Thần Nguyên Cảnh', // Thần đấu la
    'Thần Vương Cảnh', // ???
  ];

  static final honsuCap = [
    1, // Tung quan
    100, // Nhập vi
    500, // Nhập vi
    5000, // Giới tử
    20000, // Giới tử
    50000, // Hạo hãn
    100000, // Hạo hãn ???
  ];

  static final honsuMau = [
    Colors.white,
    Colors.amber,
    Colors.purple.shade700,
    Colors.black,
    Colors.pink.shade300,
    Colors.lime,
    Colors.yellow.shade300,
  ];

  final kinhnghiem = [
    100,
    10000,
    1000000,
    100000000,
    10000000000,
    1000000000000,
    100000000000000,
  ];

  TinhThanLuc();

  TinhThanLuc.fromMap(Map<String, dynamic> map) {
    tinhthanluc = map['tinhthanluc'] as int;
    honkhi = map['honkhi'] as double;
    capdo = map['capdo'] as int;
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tinhthanluc': tinhthanluc,
      'honkhi': honkhi,
      'capdo': capdo,
    };
  }

  int capDo() {
    return kinhnghiem[capdo];
  }

  bool honSu() {
    if (capdo + 1 >= kinhnghiem.length) {
      return false;
    }

    return tinhthanluc != 1 && tinhthanluc == honsuCap[capdo];
  }

  bool kinhNghiem(honkhi) {
    return honkhi >= kinhnghiem[capdo].toDouble();
  }

  String tangcap(int tinhthanluc) {
    if (tinhthanluc >= honsuCap.last) {
      return honsu.last;
    }

    if (capdo + 1 >= honsuCap.length) {
      return honsu[capdo];
    }

    if (tinhthanluc != honsuCap[capdo + 1]) {
      return honsu[capdo];
    }

    if (tinhthanluc != honsuCap.first) {
      capdo++;
    }
    return honsu[capdo];
  }

  @override
  void reset() {
    tinhthanluc = 1;
    honkhi = 0.0;
    capdo = 0;
  }
}
