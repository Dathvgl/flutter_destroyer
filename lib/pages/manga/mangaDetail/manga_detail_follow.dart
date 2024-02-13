import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/blocs/auth/auth_bloc.dart';
import 'package:flutter_destroyer/blocs/user/user_bloc.dart';
import 'package:flutter_destroyer/cubits/mangaType/manga_type_cubit.dart';
import 'package:flutter_destroyer/enum.dart';
import 'package:flutter_destroyer/models/manga/manga_detail.dart';
import 'package:flutter_destroyer/models/user/user_follow_manga.dart';
import 'package:flutter_destroyer/pages/manga/mangaDetail/manga_detail_build.dart';

class MangaDetailFollow extends StatelessWidget {
  const MangaDetailFollow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        UserFollowMangaModel? follow;

        if (userState.runtimeType == UserFollowMangaState) {
          final model = (userState as UserFollowMangaState).model;
          follow = model.id.isEmpty ? null : model;
        }

        return MangaDetailFollowDetail(follow: follow);
      },
    );
  }
}

class MangaDetailFollowDetail extends StatelessWidget {
  final UserFollowMangaModel? follow;

  const MangaDetailFollowDetail({
    super.key,
    this.follow,
  });

  @override
  Widget build(BuildContext context) {
    final inherited = MangaDetailBuildInherited.of(context) ??
        MangaDetailBuildInherited(
          id: "",
          model: MangaDetailModel.empty(),
          child: const SizedBox(),
        );

    return InkWell(
      onTap: () {
        final status = context.read<AuthBloc>().state.status;

        if (status == AuthStatus.authenticated) {
          context.read<UserBloc>().add(UserFollowMangaListen(
            id: follow?.id,
            isFollow: follow != null,
            mangaId: inherited.id,
            mangaType: context.read<MangaTypeCubit>().state.type,
          ));
        } else {
          print("Sign in to follow");
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: follow == null ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          follow == null ? "Follow" : "Unfollow",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
