// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_destroyer/models/user/user.dart';
import 'package:flutter_destroyer/models/user/user_cultivation.dart';
import 'package:flutter_destroyer/repositories/auth_repository.dart';
import 'package:flutter_destroyer/repositories/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final _authRepository = AuthRepository();
  late final UserRepository _userRepository;

  StreamSubscription<DatabaseEvent>? _userCultivationSubscription;

  UserCubit({
    required UserRepository userRepository,
  }) : super(const UserInitial()) {
    _userRepository = userRepository;
  }

  @override
  Future<void> close() {
    _userCultivationSubscription?.cancel();
    return super.close();
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    _userCultivationSubscription?.cancel();

    emit(const UserInitial());
  }

  Future<void> signInGoogle({
    required VoidCallback callback,
  }) async {
    final user = await _authRepository.signInWithGoogle();

    if (user != null) {
      callback();

      _userCultivationSubscription ??= _userRepository
          .listenUserCultivation(uid: user.uid)
          ?.listen((event) async {
        if (event.snapshot.exists) {
          final data = event.snapshot.value as Map;
          final json = Map<String, dynamic>.from(data);

          final cultivation = UserCultivationModel.fromJson(json);
          await _userRepository.updateCultivation(id: cultivation.idTuLuyen);

          emit(UserInitial(
            user: user,
            cultivation: cultivation,
          ));
        } else {
          await _userRepository.updateCultivation(id: "quocVuongVanTue");
          await _userRepository.setUserCultivation(uid: user.uid);
        }
      });
    } else {
      emit(const UserInitial());
    }
  }

  Future<void> updateCultivation({
    required String idCanhGioi,
    required int tuVi,
    required int tuViTheo,
  }) async {
    if (state.user != null) {
      await _userRepository.updateUserCultivation(
        uid: state.user!.uid,
        idCanhGioi: idCanhGioi,
        tuVi: tuVi,
        tuViTheo: tuViTheo,
      );
    }
  }
}
