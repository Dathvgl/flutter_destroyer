// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';

part 'bottom_indexed_state.dart';

class BottomIndexedCubit extends Cubit<BottomIndexedState> {
  BottomIndexedCubit() : super(BottomIndexedInitial(name: ""));

  void init(String name) {
    emit(BottomIndexedInitial(name: name));
  }

  void change(int page) {
    emit(BottomIndexedInitial(
      name: state.name,
      page: page,
    ));
  }
}
