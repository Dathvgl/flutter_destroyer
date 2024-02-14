import 'package:flutter_destroyer/components/function.dart';
import 'package:flutter_destroyer/components/interface.dart';

class HonLuc implements JsonMap, DauLaChung {
  final int id = 0;

  int honluc = 0; // Cấp hồn lực
  double honkhi = 0; // Kinh nghiệm

  int capdo = 0; // Cấp trong kinh nghiệm mỗi bậc

  bool dotpha = false; // Điều kiện nhận hồn hoàn
  bool gioihan = false; // Điều kiện sau khi nhận hồn hoàn

  static final honsu = [
    'Hồn Sĩ',
    'Hồn Sư',
    'Hồn Đại Sư',
    'Hồn Tôn',
    'Hồn Tông',
    'Hồn Vương',
    'Hồn Đế',
    'Hồn Thánh',
    'Hồn Đấu La',
    'Phong Hào Đấu La',
    'Thần Đấu La',
  ];

  static final honsuCap = [
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

  final kinhnghiem = [
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

  HonLuc();

  HonLuc.fromMap(Map<String, dynamic> map) {
    honluc = map['honluc'] as int;
    honkhi = map['honkhi'] as double;
    capdo = map['capdo'] as int;
    dotpha = map['dotpha'] as int == 1 ? true : false;
    gioihan = map['gioihan'] as int == 1 ? true : false;
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'honluc': honluc,
      'honkhi': honkhi,
      'capdo': capdo,
      'dotpha': dotpha ? 1 : 0,
      'gioihan': gioihan ? 1 : 0,
    };
  }

  int capDo() {
    return kinhnghiem[capdo];
  }

  bool honSu() {
    if (capdo + 1 >= kinhnghiem.length) {
      return false;
    }

    return honluc != 0 && intNotDecimal(honluc / 10) && !gioihan;
  }

  bool kinhNghiem(honkhi) {
    return honkhi >= kinhnghiem[capdo].toDouble();
  }

  String tangcap(int honluc) {
    if (honluc <= 0) {
      return 'Không hồn lực';
    }

    if (honluc >= honsuCap.last) {
      return honsu.last;
    }

    if (capdo + 1 >= honsuCap.length) {
      return honsu[capdo];
    }

    if (honluc != honsuCap[capdo + 1]) {
      return honsu[capdo];
    }

    if (honluc != honsuCap.first) {
      capdo++;
    }
    return honsu[capdo];
  }

  @override
  void reset() {
    honluc = 0;
    honkhi = 0.0;
    capdo = 0;
    dotpha = false;
    gioihan = false;
  }
}
