part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  final UserModel? user;
  final UserCultivationModel? cultivation;

  const UserState({
    this.user,
    this.cultivation,
  });

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {
  const UserInitial({
    super.user,
    super.cultivation,
  });
}
