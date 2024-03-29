import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:flutter_destroyer/models/tuTien/tuTiens/quoc_vuong_van_tue.dart';

class TuTienModel {
  final String id;
  final String name;
  final String path;

  TuTienModel({
    required this.id,
    required this.name,
    required this.path,
  });

  factory TuTienModel.fromJson(Map<String, dynamic> json) {
    return TuTienModel(
      id: json["id"] as String,
      name: json["name"] as String,
      path: json["path"] as String,
    );
  }

  static Future<QuocVuongVanTueModel?> tuLuyen({
    required String id,
    required List<TuTienModel> tuTiens,
  }) async {
    final data = tuTiens.firstWhereOrNull((item) => item.id == id);

    if (data == null) {
      return null;
    }

    final json = await rootBundle.loadString(data.path);

    switch (id) {
      case "quocVuongVanTue":
      default:
        return await QuocVuongVanTueModel.deepJson(
          id: id,
          json: jsonDecode(json),
        );
    }
  }
}

class TuLuyenModel {
  final String id;
  final TuLuyenCanhGioiModel canhGioi;

  const TuLuyenModel({
    required this.id,
    required this.canhGioi,
  });

  const TuLuyenModel.empty({
    this.id = "",
    this.canhGioi = TuLuyenCanhGioiModel.empty,
  });
}

class TuLuyenCanhGioiModel {
  final CanhGioiModel phamNhan;
  const TuLuyenCanhGioiModel({required this.phamNhan});

  static const empty = TuLuyenCanhGioiModel(
    phamNhan: CanhGioiModel.empty,
  );

  Map<String, CanhGioiModel> toJson() {
    return {"phamNhan": phamNhan};
  }

  CanhGioiModel? deepRealm(CanhGioiModel? canhGioi) {
    CanhGioiModel? data = canhGioi;

    while (true) {
      if (data?.tieuCanhGioi == null) {
        break;
      } else {
        data = data?.tieuCanhGioi?.first;
      }
    }

    return data;
  }

  CanhGioiModel? nextRealm({
    required int result,
    CanhGioiModel? canhGioi,
  }) {
    CanhGioiModel? data = canhGioi;

    while (true) {
      if (data == null) {
        break;
      } else {
        if (data.tuVi > result) {
          data = deepRealm(get(data.prevId));
          break;
        } else {
          data = deepRealm(get(data.nextId));
        }
      }
    }

    return data;
  }

  CanhGioiModel? get(String? name) {
    if (name == null) return null;

    final json = toJson();
    final split = name.split("-");
    final length = split.length;

    if (json.containsKey(split[0])) {
      CanhGioiModel? model = json[split[0]];

      for (var i = 1; i < length; i++) {
        final lastest = model?.tieuCanhGioi
            ?.firstWhereOrNull((item) => item.id == split[i]);

        if (lastest == null) break;
        model = lastest;
      }

      return model;
    }

    return null;
  }
}

class CanhGioiModel {
  final String id;
  final String? subId;
  final String? prevId;
  final String? nextId;
  final String canhGioi;
  final String xungHo;
  final int tuVi;
  final String? chucNang;
  final String? dieuKien;
  final List<CanhGioiModel>? tieuCanhGioi;

  const CanhGioiModel({
    required this.id,
    this.subId,
    this.prevId,
    this.nextId,
    required this.canhGioi,
    required this.xungHo,
    required this.tuVi,
    this.chucNang,
    this.dieuKien,
    this.tieuCanhGioi,
  });

  static const empty = CanhGioiModel(
    id: "",
    canhGioi: "",
    xungHo: "",
    tuVi: 0,
  );

  String get backId => subId == null ? id : "$subId-$id";

  factory CanhGioiModel.fromJson(Map<String, dynamic> json) {
    return CanhGioiModel(
      id: json["id"] as String,
      subId: json["subId"] as String?,
      prevId: json["prevId"] as String?,
      nextId: json["nextId"] as String?,
      canhGioi: json["canhGioi"] as String,
      xungHo: json["xungHo"] as String,
      tuVi: json["tuVi"] as int,
      chucNang: json["chucNang"] as String?,
      dieuKien: json["dieuKien"] as String?,
      tieuCanhGioi: json["tieuCanhGioi"] == null
          ? null
          : (json["tieuCanhGioi"] as List)
              .map((e) => CanhGioiModel.fromJson(e))
              .toList(),
    );
  }
}
