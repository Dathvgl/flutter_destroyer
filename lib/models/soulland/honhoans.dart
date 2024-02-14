import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_destroyer/components/function.dart';
import 'package:flutter_destroyer/components/interface.dart';

class HonHoan implements JsonMap, JsonList, DauLaChung {
  final int id = 3;
  double heso = 0.0;

  List<HonLinh> honlinh = [];

  HonHoan();

  HonHoan.fromMap(Map<String, dynamic> map) {
    heso = map['heso'] as double;
    honlinh = mapList(map['honlinh']) as List<HonLinh>;
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'heso': heso,
      'honlinh': jsonEncode(
        honlinh
            .map((x) => jsonEncode(
                  x.toMap(),
                ).toString())
            .toList(),
      ).toString(),
    };
  }

  @override
  List mapList(String str) {
    Iterable list = jsonDecode(str);
    return list
        .map((x) => HonLinh.fromMap(
              jsonDecode(x),
            ))
        .toList();
  }

  void thuHonLinh() {
    int index = honlinh.length;

    if (honlinh.length >= 10) {
      return;
    }

    heso += HonLinh.hontro.first;
    honlinh.add(HonLinh(
      tenhon: '${HonLinh.honhieu[index]} Hồn Hoàn',
      heso: HonLinh.hontro.first,
    ));
  }

  void thuHonKhi(double honkhi) {
    if (honlinh.isEmpty) {
      return;
    }

    int soluong = honlinh.where((element) => element.tangnam == true).length;

    if (soluong == 0) {
      return;
    }

    double linhngo = honkhi / soluong;
    for (var item in honlinh) {
      if (!item.tangnam) {
        continue;
      }
      item.honkhi += linhngo;
    }
  }

  @override
  void reset() {
    heso = 0.0;
    honlinh.clear();
  }
}

class HonLinh implements JsonMap {
  int capdo = 0;
  String tenhon = '';
  int sonam = 0;
  double heso = 0.0;

  bool tangnam = false;

  double honkhi = 0.0;
  final int honkhiCoBan = 10;

  // Xám - Trắng - Vàng - Tím - Đen - Đỏ - Thần sắc
  static final honten = [
    'Không Năm Hồn Hoàn',
    'Mười Năm Hồn Hoàn',
    'Trăm Năm Hồn Hoàn',
    'Nghìn Năm Hồn Hoàn',
    'Vạn Năm Hồn Hoàn',
    'Mười Vạn Năm Hồn Hoàn',
    'Trăm Vạn Năm Hồn Hoàn',
  ];

  static final honnam = [
    0,
    10,
    100,
    1000,
    10000,
    100000,
    1000000,
  ];

  static final honanh = [
    'assets/images/honHoan/Picture1.png',
    'assets/images/honHoan/Picture2.png',
    'assets/images/honHoan/Picture3.png',
    'assets/images/honHoan/Picture4.png',
    'assets/images/honHoan/Picture5.png',
    'assets/images/honHoan/Picture6.png',
    'assets/images/honHoan/Picture7.png',
  ];

  static final honmau = [
    const Color(0xffa6a6a6),
    const Color(0xffffffff),
    const Color(0xffffe699),
    const Color(0xff8926ec),
    const Color(0xff000000),
    const Color(0xffc00000),
    const Color(0xffffffff),
  ];

  static final hontro = [
    2.0,
    5.0,
    12.0,
    30.0,
    55.0,
    200.0,
    220.0,
  ];

  static final honhieu = [
    'Nhất',
    'Nhị',
    'Tam',
    'Tứ',
    'Ngũ',
    'Lục',
    'Thất',
    'Bát',
    'Cửu',
    'Thập',
  ];

  HonLinh({
    required this.tenhon,
    required this.heso,
  });

  HonLinh.fromMap(Map<String, dynamic> map) {
    capdo = map['capdo'] as int;
    tenhon = map['tenhon'] as String;
    sonam = map['sonam'] as int;
    heso = map['heso'] as double;
    tangnam = map['tangnam'] as int == 1 ? true : false;
    honkhi = map['honkhi'] as double;
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'capdo': capdo,
      'tenhon': tenhon,
      'sonam': sonam,
      'heso': heso,
      'tangnam': tangnam ? 1 : 0,
      'honkhi': honkhi,
    };
  }

  int capDo() {
    if (capdo <= 0) {
      return honkhiCoBan;
    }

    if (capdo + 1 >= honnam.length) {
      return (honkhiCoBan * honnam.last * (log10(sonam) / capdo) / capdo)
          .round();
    }

    return (honkhiCoBan * honnam[capdo] * (log10(sonam) / capdo) / capdo)
        .round();
  }

  bool honSu() {
    if (capdo + 1 >= honnam.length) {
      return false;
    }

    return sonam != 0 && sonam == honnam[capdo + 1];
  }
}
