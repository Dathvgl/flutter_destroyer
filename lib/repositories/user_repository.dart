import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_destroyer/models/tuTien/tuTiens/quoc_vuong_van_tue.dart';
import 'package:flutter_destroyer/models/tuTien/tu_tien.dart';

class UserRepository {
  final _firebaseDatabase = FirebaseDatabase.instance;

  List<TuTienModel> _tuTiens = [];
  QuocVuongVanTueModel? _tuLuyen;

  set tuTiens(List<TuTienModel> tuTiens) {
    _tuTiens = tuTiens;
  }

  Future<void> updateCultivation({
    required String id,
  }) async {
    _tuLuyen = await TuTienModel.tuLuyen(
      id: id,
      tuTiens: _tuTiens,
    );
  }

  Stream<DatabaseEvent>? listenUserCultivation({
    String? uid,
  }) {
    if (uid == null || uid.isEmpty) {
      return null;
    }

    return _firebaseDatabase.ref("cultivation/$uid").onValue;
  }

  Future<void> setUserCultivation({
    required String uid,
  }) async {
    if (_tuLuyen != null) {
      await _firebaseDatabase.ref("cultivation/$uid").set({
        "idTuLuyen": _tuLuyen!.id,
        "idCanhGioi": _tuLuyen!.canhGioi.phamNhan.id,
        "xungHo": _tuLuyen!.canhGioi.phamNhan.xungHo,
        "tuVi": 0,
      });
    }
  }

  Future<void> updateUserCultivation({
    required String uid,
    required String idCanhGioi,
    required int tuVi,
    required int tuViTheo,
  }) async {
    if (idCanhGioi.isEmpty) {
      await updateCultivation(id: "quocVuongVanTue");
      await setUserCultivation(uid: uid);
    }

    int multiple = tuViTheo;
    final result = tuVi + multiple;

    Map<String, dynamic> map = {
      "tuVi": ServerValue.increment(multiple),
    };

    final canhGioi = _tuLuyen?.canhGioi.get(idCanhGioi);
    final canhGioiMoi = _tuLuyen?.canhGioi.nextRealm(
      result: result,
      canhGioi: _tuLuyen?.canhGioi.get(canhGioi?.nextId),
    );

    if (canhGioi?.id != canhGioiMoi?.id) {
      if (canhGioiMoi != null) {
        map = {
          "idCanhGioi": canhGioiMoi.backId,
          "xungHo": canhGioiMoi.xungHo,
          "tuVi": ServerValue.increment(multiple),
        };
      }
    }

    await _firebaseDatabase.ref("cultivation/$uid").update(map);
  }
}
