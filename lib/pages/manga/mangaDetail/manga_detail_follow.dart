import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/cubits/manga/manga_cubit.dart';
import 'package:flutter_destroyer/cubits/user/user_cubit.dart';
import 'package:flutter_destroyer/pages/manga/mangaDetail/page.dart';

class MangaDetailFollow extends StatelessWidget {
  const MangaDetailFollow({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = MangaDetailInherited.of(context);

    if (inherited == null) {
      return const SizedBox();
    }

    return BlocBuilder<MangaCubit, MangaState>(
      buildWhen: (previous, current) {
        return previous.userFollow != current.userFollow;
      },
      builder: (context, state) {
        return InkWell(
          onTap: () {
            final user = context.read<UserCubit>().state.user;

            if (user == null) {
              return;
            }

            final cubit = context.read<MangaCubit>();

            if (state.userFollow == null) {
              cubit.postMangaUserFollow(
                detailId: inherited.id,
              );
            } else {
              cubit.deleteMangaUserFollow(
                id: inherited.id,
              );
            }

            cubit.getMangaUserFollow(id: inherited.id);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: state.userFollow == null ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              state.userFollow == null ? "Theo dõi" : "Hủy theo dõi",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
