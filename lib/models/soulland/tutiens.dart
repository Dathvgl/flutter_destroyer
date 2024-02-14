import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_destroyer/components/function.dart';
import 'package:flutter_destroyer/components/interface.dart';
import 'package:flutter_destroyer/models/soulland/honhoans.dart';
import 'package:flutter_destroyer/models/soulland/honlucs.dart';
import 'package:flutter_destroyer/models/soulland/tinhthanlucs.dart';
import 'package:flutter_destroyer/models/soulland/vohons.dart';
import 'package:flutter_destroyer/models/soulland/congphaps.dart';

class TuTien extends ChangeNotifier implements JsonMap {
  final int id = 100;

  String honsu = 'fsfssfssfsfsfs';
  double honkhi = 0.0;
  double cobanHonKhi = 0.01;

  bool tuluyen = false;
  List<double> phanHonKhi = [
    0.0,
    0.0,
    0.0,
    0.0,
  ];

  VoHon vohon = VoHon();
  HonLuc honluc = HonLuc();
  TinhThanLuc tinhthanluc = TinhThanLuc();
  HonHoan honhoan = HonHoan();
  CongPhap congphap = CongPhap();

  TuTien();

  TuTien.fromMap(Map<String, dynamic> map) {
    honsu = map['honsu'] as String;
    honkhi = map['honkhi'] as double;
    tuluyen = map['tuluyen'] as int == 1 ? true : false;

    vohon = VoHon.fromMap(jsonDecode(
      map['vohon'],
    ) as Map<String, dynamic>);

    honluc = HonLuc.fromMap(jsonDecode(
      map['honluc'],
    ) as Map<String, dynamic>);

    tinhthanluc = TinhThanLuc.fromMap(jsonDecode(
      map['tinhthanluc'],
    ) as Map<String, dynamic>);

    honhoan = HonHoan.fromMap(jsonDecode(
      map['honhoan'],
    ) as Map<String, dynamic>);

    congphap = CongPhap.fromMap(jsonDecode(
      map['congphap'],
    ) as Map<String, dynamic>);
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'honsu': honsu,
      'honkhi': honkhi,
      'tuluyen': tuluyen ? 1 : 0,
      'vohon': jsonEncode(vohon.toMap()).toString(),
      'honluc': jsonEncode(honluc.toMap()).toString(),
      'tinhthanluc': jsonEncode(tinhthanluc.toMap()).toString(),
      'honhoan': jsonEncode(honhoan.toMap()).toString(),
      'congphap': jsonEncode(congphap.toMap()).toString(),
    };
  }

  void updateReset() {
    vohon.reset();
    honluc.reset();
    tinhthanluc.reset();
    honhoan.reset();
    congphap.reset();

    notifyListeners();
  }

  void updateHonKhi() {
    double hesoHTC = congphap.huyenThienBaoLuc[HuyenThienCong.dacthu].heso;

    honkhi = cobanHonKhi + cobanHonKhi * heso();
    honkhi *= (5 + hesoHTC + vohon.heso);

    if (honkhi < 1) {
      honkhi = double.parse(honkhi.toStringAsFixed(2));
    }

    if (honkhi >= 1) {
      honkhi = double.parse(honkhi.toStringAsFixed(0));
    }

    if (phanHonKhi[honluc.id] > 0 && !honluc.dotpha) {
      honluc.honkhi += honkhi * phanHonKhi[honluc.id];
    }

    if (phanHonKhi[tinhthanluc.id] > 0 /*  && !honluc.dotpha */) {
      tinhthanluc.honkhi += honkhi * phanHonKhi[tinhthanluc.id];
    }

    if (phanHonKhi[congphap.id] > 0) {
      congphap.honkhi += honkhi * phanHonKhi[congphap.id];
    }

    if (phanHonKhi[honhoan.id] > 0) {
      honhoan.thuHonKhi(honkhi * phanHonKhi[honhoan.id]);
    }

    notifyListeners();
  }

  void updateVoHon(int index) {
    Random random = Random();

    int n = vohon.loaivohon[index].baogom.length;
    int count = random.nextInt(n);

    vohon.ten = vohon.loaivohon[index].baogom[count];
    notifyListeners();
  }

  void updatePhamVoHon() {
    if (vohon.capdo == 0) {
      if (honluc.honluc <= 30) {
        return;
      }

      vohon.capdo++;
      vohon.heso = VoHon.hontro[vohon.capdo];
      notifyListeners();
      return;
    }

    if (vohon.capdo == 1) {
      int hh = honhoan.honlinh.where((item) => item.sonam > 100).length;
      int cp = congphap.huyenThienBaoLuc
          .where((item) => item.capdo > 100 && item.tangcap)
          .length;

      if (hh + cp < 6) {
        return;
      }

      vohon.capdo++;
      vohon.heso = VoHon.hontro[vohon.capdo];
      notifyListeners();
      return;
    }

    if (vohon.capdo == 2) {
      if (honluc.honluc <= 40) {
        return;
      }

      if (tinhthanluc.tinhthanluc < 500) {
        return;
      }

      int cp = congphap.huyenThienBaoLuc
          .where((item) => item.capdo > 500 && item.tangcap)
          .length;

      if (cp < 3) {
        return;
      }

      vohon.capdo++;
      vohon.heso = VoHon.hontro[vohon.capdo];
      notifyListeners();
      return;
    }

    if (vohon.capdo == 3) {
      if (honluc.honluc <= 50) {
        return;
      }

      int hh = honhoan.honlinh.where((item) => item.sonam > 1000).length;

      if (hh < 4) {
        return;
      }

      vohon.capdo++;
      vohon.heso = VoHon.hontro[vohon.capdo];
      notifyListeners();
      return;
    }

    if (vohon.capdo == 4) {
      if (honluc.honluc <= 60) {
        return;
      }

      if (tinhthanluc.tinhthanluc < 5000) {
        return;
      }

      int hh = honhoan.honlinh.where((item) => item.sonam > 10000).length;

      if (hh < 4) {
        return;
      }

      vohon.capdo++;
      vohon.heso = VoHon.hontro[vohon.capdo];
      notifyListeners();
      return;
    }

    if (vohon.capdo == 5) {
      if (honluc.honluc <= 70) {
        return;
      }

      int hh = honhoan.honlinh.where((item) => item.sonam > 10000).length;
      int cp = congphap.huyenThienBaoLuc
          .where((item) => item.capdo > 5000 && item.tangcap)
          .length;

      if (hh + cp < 10) {
        return;
      }

      vohon.capdo++;
      vohon.heso = VoHon.hontro[vohon.capdo];
      notifyListeners();
      return;
    }

    if (vohon.capdo == 6) {
      if (honluc.honluc <= 80) {
        return;
      }

      if (tinhthanluc.tinhthanluc < 20000) {
        return;
      }

      int hh = honhoan.honlinh.where((item) => item.sonam > 100000).length;

      if (hh <= 0) {
        return;
      }

      vohon.capdo++;
      vohon.heso = VoHon.hontro[vohon.capdo];
      notifyListeners();
      return;
    }

    if (vohon.capdo == 7) {
      if (honluc.honluc < 95) {
        return;
      }

      int hh = honhoan.honlinh.where((item) => item.sonam > 100000).length;
      int cp = congphap.huyenThienBaoLuc
          .where((item) => item.capdo > 10000 && item.tangcap)
          .length;

      if (hh + cp < 9) {
        return;
      }

      vohon.capdo++;
      vohon.heso = VoHon.hontro[vohon.capdo];
      notifyListeners();
      return;
    }

    if (vohon.capdo == 8) {
      if (honluc.honluc < 99) {
        return;
      }

      if (tinhthanluc.tinhthanluc < 50000) {
        return;
      }

      int hh = honhoan.honlinh.where((item) => item.sonam > 100000).length;
      int cp = congphap.huyenThienBaoLuc
          .where((item) => item.capdo > 100000 && item.tangcap)
          .length;

      if (hh + cp < 12) {
        return;
      }

      vohon.capdo++;
      vohon.heso = VoHon.hontro[vohon.capdo];
      notifyListeners();
    }
  }

  void updatePhanHonKhi(int index, double rate) {
    phanHonKhi[index] = rate;
    notifyListeners();
  }

  void updateHonLuc() {
    honluc.honluc++;
    honluc.honkhi = 0.0;
    honluc.gioihan = false;
    notifyListeners();
  }

  void updateHonLucDotPha() {
    honluc.dotpha = !honluc.dotpha;
    honluc.gioihan = true;
    notifyListeners();
  }

  void updateTinhThanLuc() {
    int kinhnghiem = tinhthanluc.kinhnghiem[TinhThanLuc.capdo];
    double duthua = tinhthanluc.honkhi - kinhnghiem;

    tinhthanluc.tinhthanluc++;
    tinhthanluc.honkhi = duthua;

    int ttl = tinhthanluc.tinhthanluc;
    double heso = congphap.huyenThienBaoLuc[TuCucMaDong.dacthu].hesogoc;

    double pw = pow(ttl, 1 / heso).toDouble();
    double result = pw * ttl;

    congphap.huyenThienBaoLuc[TuCucMaDong.dacthu].heso = result;
    notifyListeners();
  }

  // void updateTinhThanLucDotPha() {
  //   notifyListeners();
  // }

  void updateHonHoan(int count) {
    int kinhnghiem = honhoan.honlinh[count].capDo();
    double duthua = honhoan.honlinh[count].honkhi - kinhnghiem;

    honhoan.honlinh[count].sonam++;
    honhoan.honlinh[count].honkhi = duthua;

    int sonam = honhoan.honlinh[count].sonam;
    double heso = HonLinh.hontro[honhoan.honlinh[count].capdo];

    honhoan.heso -= honhoan.honlinh[count].heso;

    double pw1 = pow(heso, 2).toDouble();
    double pw2 = pow(sonam, 1 / heso).toDouble();
    honhoan.honlinh[count].heso = pw1 + pw2 * sonam;

    honhoan.heso += honhoan.honlinh[count].heso;

    notifyListeners();
  }

  void updateHonHoanDotPha(int count) {
    if (honhoan.honlinh[count].capdo >= HonLinh.honten.length) {
      return;
    }

    honhoan.heso -= honhoan.honlinh[count].heso;
    honhoan.honlinh[count].capdo++;

    int sonam = honhoan.honlinh[count].sonam;
    double heso = HonLinh.hontro[honhoan.honlinh[count].capdo];
    honhoan.honlinh[count].heso = heso * log10(sonam);
    honhoan.heso += honhoan.honlinh[count].heso;

    notifyListeners();
  }

  void updateTichHonLinh(int count, bool value) {
    honhoan.honlinh[count].tangnam = value;
    notifyListeners();
  }

  void updateTuLuyen() {
    tuluyen = !tuluyen;
    notifyListeners();
  }

  double heso() {
    double hesoTCMD = congphap.huyenThienBaoLuc[TuCucMaDong.dacthu].heso;
    return (congphap.heso + hesoTCMD) + honhoan.heso /*  + vohon.heso */;
  }
}
