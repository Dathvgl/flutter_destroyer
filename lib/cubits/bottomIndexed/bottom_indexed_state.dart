part of 'bottom_indexed_cubit.dart';

sealed class BottomIndexedState {
  String name;
  int page;

  BottomIndexedState({
    required this.name,
    this.page = 1,
  });
}

final class BottomIndexedInitial extends BottomIndexedState {
  BottomIndexedInitial({
    required super.name,
    super.page,
  });
}
