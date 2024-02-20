part of 'manga_cubit.dart';

sealed class MangaState extends Equatable {
  final MangaType type;
  final MangaUserFollow? userFollow;

  const MangaState({
    this.type = MangaType.nettruyen,
    this.userFollow,
  });

  @override
  List<Object> get props => [];
}

final class MangaInitial extends MangaState {
  const MangaInitial({
    super.type,
    super.userFollow,
  });
}
