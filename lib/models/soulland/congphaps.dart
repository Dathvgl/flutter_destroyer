import 'dart:convert';
import 'dart:math';

import 'package:flutter_destroyer/components/interface.dart';
import 'package:flutter_destroyer/models/soulland/honlucs.dart';
import 'package:flutter_destroyer/models/soulland/tinhthanlucs.dart';

class CongPhap implements JsonMap, JsonList, DauLaChung {
  final int id = 2;
  final String bophap = 'Huyền Thiên Bảo Lục';

  double honkhi = 0.0;
  int phanchia = 0;

  double heso = 0.0;

  List<CoSoChung> huyenThienBaoLuc = [
    HuyenThienCong(),
    HuyenNgocThu(),
    TuCucMaDong(),
    QuyAnhMeTung(),
    KhongHacCamLong(),
  ];

  CongPhap() {
    phanchia = huyenThienBaoLuc.length;
    for (var item in huyenThienBaoLuc) {
      if (!item.tangcap) {
        phanchia--;
        continue;
      }
      item.coban();
    }
    thayHeSo();
  }

  CongPhap.fromMap(Map<String, dynamic> map) {
    honkhi = map['honkhi'];
    phanchia = map['phanchia'];
    heso = map['heso'];
    huyenThienBaoLuc = mapList(map['huyenThienBaoLuc']);
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'honkhi': honkhi,
      'phanchia': phanchia,
      'heso': heso,
      'huyenThienBaoLuc': jsonEncode(
        huyenThienBaoLuc
            .map((x) => jsonEncode(
                  x.toMap(),
                ).toString())
            .toList(),
      ).toString(),
    };
  }

  @override
  List<CoSoChung> mapList(String str) {
    List<CoSoChung> list = [];

    Iterable map = jsonDecode(str);
    final int n = map.length;

    for (var i = 0; i < n; i++) {
      final item = jsonDecode(map.elementAt(i));
      list.add(mapCongPhap(i, item));
    }
    return list;
  }

  CoSoChung mapCongPhap(int index, Map<String, dynamic> map) {
    switch (index) {
      case 0:
        return HuyenThienCong.fromMap(map);
      case 1:
        return HuyenNgocThu.fromMap(map);
      case 2:
        return TuCucMaDong.fromMap(map);
      case 3:
        return QuyAnhMeTung.fromMap(map);
      case 4:
        return KhongHacCamLong.fromMap(map);
      default:
    }
    return CoSoChung();
  }

  void thayHeSo() {
    heso = 0.0;
    for (var item in huyenThienBaoLuc) {
      if (item.id == HuyenThienCong.dacthu) {
        continue;
      }

      heso += item.heso;
    }
  }

  double luotCongPhap(double honkhi) {
    if (phanchia <= 0) {
      return 0.0;
    }

    double kinhnghiem = honkhi / phanchia;
    return kinhnghiem;
  }

  @override
  void reset() {
    honkhi = 0.0;

    for (var item in huyenThienBaoLuc) {
      item.reset();
    }

    thayHeSo();
  }
}

class CoSoChung implements JsonMap, DauLaChung {
  int id = -1;
  String ten = '';
  double heso = 0.0;
  double hesogoc = 0.0;

  String canhgioi = 'Không có';
  double linhngo = 0.0;

  int capdo = 1;
  int kinhnghiem = 0;
  int kinhnghiemgoc = 10;
  bool tangcap = true;

  CoSoChung({
    this.id = -1,
    this.ten = '',
    this.heso = 0.0,
    this.hesogoc = 0.0,
    this.canhgioi = 'Không có',
  });

  // CoSoChung.fromMap(Map<String, dynamic> map) {
  //   id = map['id'] as int;
  //   ten = map['ten'] as String;
  //   heso = map['heso'] as double;
  //   hesogoc = map['hesogoc'] as double;
  //   canhgioi = map['canhgioi'] as String;
  //   linhngo = map['linhngo'] as double;
  //   capdo = map['capdo'] as int;
  //   kinhnghiem = map['kinhnghiem'] as int;
  //   kinhnghiemgoc = map['kinhnghiemgoc'] as int;
  //   tangcap = map['tangcap'] as int == 1 ? true : false;
  // }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ten': ten,
      'heso': heso,
      'hesogoc': hesogoc,
      'canhgioi': canhgioi,
      'linhngo': linhngo,
      'capdo': capdo,
      'kinhnghiem': kinhnghiem,
      'kinhnghiemgoc': kinhnghiemgoc,
      'tangcap': tangcap ? 1 : 0,
    };
  }

  void coban() {
    if (capdo == 1) {
      canhgioi == 'Cấp $capdo';
      kinhnghiem = kinhnghiemgoc;
    }
  }

  void canhGioi(num exp) {
    linhngo -= kinhnghiem;

    capdo++;
    heso = hesogoc + hesogoc * capdo;
    canhgioi == 'Cấp $capdo';

    double newExp = kinhnghiemgoc * capdo * hesogoc;
    kinhnghiem = kinhnghiemgoc + newExp.round();
  }

  bool kinhNghiem() {
    return linhngo >= kinhnghiem.toDouble();
  }

  @override
  void reset() {
    capdo = 1;
    kinhnghiem = 0;
    kinhnghiemgoc = 10;
  }
}

class HuyenThienCong extends CoSoChung {
  static const int dacthu = 0;

  final tangLinhNgo = [
    'Nhập môn',
    'Tầng thứ 1',
    'Tầng thứ 2',
    'Tầng thứ 3',
    'Tầng thứ 4',
    'Tầng thứ 5',
    'Tầng thứ 6',
    'Tầng thứ 7',
    'Tầng thứ 8',
    'Tầng thứ 9',
    'Tầng thứ 10',
  ];

  final tangHeSo = [
    1.0,
    2.5,
    5.0,
    7.5,
    10.0,
    12.5,
    15.0,
    17.5,
    20.0,
    22.5,
    25.0,
  ];

  HuyenThienCong({
    super.id = 0,
    super.ten = 'Huyền Thiên Công',
    super.canhgioi = 'Nhập môn',
  }) {
    capdo = 0;
    tangcap = false;
  }

  HuyenThienCong.fromMap(Map<String, dynamic> map) {
    id = map['id'] as int;
    ten = map['ten'] as String;
    heso = map['heso'] as double;
    canhgioi = map['canhgioi'] as String;
    capdo = map['capdo'] as int;
    tangcap = map['tangcap'] as int == 1 ? true : false;
  }

  @override
  void canhGioi(num exp) {
    if (exp <= 0) {
      heso = tangHeSo.first;
      canhgioi = tangLinhNgo.first;
      return;
    }

    if (exp >= HonLuc.honsuCap.last) {
      heso = tangHeSo.last;
      canhgioi = tangLinhNgo.last;
      return;
    }

    if (capdo + 1 >= tangLinhNgo.length) {
      return;
    }

    if (exp < HonLuc.honsuCap[capdo + 1]) {
      return;
    }

    capdo++;
    heso = tangHeSo[capdo];
    canhgioi = tangLinhNgo[capdo];
  }

  @override
  void reset() {
    // super.reset();
    capdo = 0;
  }
}

class HuyenNgocThu extends CoSoChung {
  HuyenNgocThu({
    super.id = 1,
    super.ten = 'Huyền Ngọc Thủ',
    super.heso = 0.2,
    super.hesogoc = 0.2,
  });

  HuyenNgocThu.fromMap(Map<String, dynamic> map) {
    id = map['id'] as int;
    ten = map['ten'] as String;
    heso = map['heso'] as double;
    hesogoc = map['hesogoc'] as double;
    canhgioi = map['canhgioi'] as String;
    linhngo = map['linhngo'] as double;
    capdo = map['capdo'] as int;
    kinhnghiem = map['kinhnghiem'] as int;
    kinhnghiemgoc = map['kinhnghiemgoc'] as int;
    tangcap = map['tangcap'] as int == 1 ? true : false;
  }

  @override
  void reset() {
    super.reset();

    heso = 0.2;
    hesogoc = 0.2;
  }
}

class TuCucMaDong extends CoSoChung {
  static const int dacthu = 2;

  final tangLinhNgo = [
    'Tung Quan',
    'Nhập Vi',
    'Giới Tử',
    'Hạo Hãn',
  ];

  final tangHeSo = [
    30.0,
    25.0,
    22.5,
    20.0,
  ];

  TuCucMaDong({
    super.id = 2,
    super.ten = 'Tử Cực Ma Đồng',
    super.canhgioi = 'Tung Quan',
  }) {
    kinhnghiem = 0;
    tangcap = false;
  }

  TuCucMaDong.fromMap(Map<String, dynamic> map) {
    id = map['id'] as int;
    ten = map['ten'] as String;
    heso = map['heso'] as double;
    hesogoc = map['hesogoc'] as double;
    canhgioi = map['canhgioi'] as String;
    capdo = map['capdo'] as int;
    kinhnghiem = map['kinhnghiem'] as int;
    tangcap = map['tangcap'] as int == 1 ? true : false;
  }

  @override
  void canhGioi(num exp) {
    if (exp <= 1) {
      hesogoc = tangHeSo.first;

      double pw = pow(exp, 1 / hesogoc).toDouble();
      heso = pw * exp;

      canhgioi = tangLinhNgo.first;
      return;
    }

    if (exp >= TinhThanLuc.honsuCap.last || TinhThanLuc.capdo > 4) {
      capdo = 3;
      if (kinhnghiem < capdo) {
        kinhnghiem = 3;
        hesogoc = tangHeSo.last;

        double pw = pow(exp, 1 / hesogoc).toDouble();
        heso = pw * exp;

        canhgioi = tangLinhNgo.last;
      }
      return;
    }

    if (TinhThanLuc.capdo >= tangLinhNgo.length) {
      return;
    }

    if (TinhThanLuc.capdo == 1 || TinhThanLuc.capdo == 2) {
      capdo = 1;
      if (kinhnghiem < capdo) {
        kinhnghiem = 1;
        hesogoc = tangHeSo[kinhnghiem];

        double pw = pow(exp, 1 / hesogoc).toDouble();
        heso = pw * exp;

        canhgioi = tangLinhNgo[kinhnghiem];
      }
      return;
    }

    if (TinhThanLuc.capdo == 3 || TinhThanLuc.capdo == 4) {
      capdo = 2;
      if (kinhnghiem < capdo) {
        kinhnghiem = 2;
        hesogoc = tangHeSo[kinhnghiem];

        double pw = pow(exp, 1 / hesogoc).toDouble();
        heso = pw * exp;

        canhgioi = tangLinhNgo[kinhnghiem];
      }
    }
  }
}

class QuyAnhMeTung extends CoSoChung {
  QuyAnhMeTung({
    super.id = 3,
    super.ten = 'Quỷ Ảnh Mê Tung',
    super.heso = 0.35,
    super.hesogoc = 0.35,
  });

  QuyAnhMeTung.fromMap(Map<String, dynamic> map) {
    id = map['id'] as int;
    ten = map['ten'] as String;
    heso = map['heso'] as double;
    hesogoc = map['hesogoc'] as double;
    canhgioi = map['canhgioi'] as String;
    linhngo = map['linhngo'] as double;
    capdo = map['capdo'] as int;
    kinhnghiem = map['kinhnghiem'] as int;
    kinhnghiemgoc = map['kinhnghiemgoc'] as int;
    tangcap = map['tangcap'] as int == 1 ? true : false;
  }

  @override
  void reset() {
    super.reset();

    heso = 0.35;
    hesogoc = 0.35;
  }
}

class KhongHacCamLong extends CoSoChung {
  KhongHacCamLong({
    super.id = 4,
    super.ten = 'Khống Hạc Cầm Long',
    super.heso = 0.275,
    super.hesogoc = 0.275,
  });

  KhongHacCamLong.fromMap(Map<String, dynamic> map) {
    id = map['id'] as int;
    ten = map['ten'] as String;
    heso = map['heso'] as double;
    hesogoc = map['hesogoc'] as double;
    canhgioi = map['canhgioi'] as String;
    linhngo = map['linhngo'] as double;
    capdo = map['capdo'] as int;
    kinhnghiem = map['kinhnghiem'] as int;
    kinhnghiemgoc = map['kinhnghiemgoc'] as int;
    tangcap = map['tangcap'] as int == 1 ? true : false;
  }

  @override
  void reset() {
    super.reset();

    heso = 0.275;
    hesogoc = 0.275;
  }
}
