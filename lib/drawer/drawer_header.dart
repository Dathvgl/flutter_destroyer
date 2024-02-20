import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/cubits/cultivation/cultivation_cubit.dart';
import 'package:flutter_destroyer/cubits/user/user_cubit.dart';
import 'package:flutter_destroyer/drawer/index.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DrawerRootHeader extends StatelessWidget {
  const DrawerRootHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = DrawerRootInherited.of(context);

    if (inherited == null) {
      return const SizedBox();
    }

    final user = inherited.user;

    if (user == null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        height: AppBar().preferredSize.height,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Fsfssfssfsfsfs",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    foregroundImage: user.thumnail == null
                        ? null
                        : CachedNetworkImageProvider(user.thumnail!),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name ?? "empty",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      BlocBuilder<UserCubit, UserState>(
                        builder: (context, state) {
                          if (state.cultivation == null) {
                            return const SizedBox();
                          }

                          return Text(
                            state.cultivation!.xungHo,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<CultivationCubit, CultivationState>(
            builder: (context, cultivationState) {
              final canhGioi = cultivationState.tuLuyen.canhGioi;

              return BlocBuilder<UserCubit, UserState>(
                builder: (context, userState) {
                  if (userState.cultivation == null) {
                    return const SizedBox();
                  }

                  double percent = 0;

                  final current =
                      canhGioi.get(userState.cultivation!.idCanhGioi);
                  final next = canhGioi.get(current?.nextId);

                  if (current != null && next != null) {
                    final need = userState.cultivation!.tuVi - current.tuVi;
                    final total = next.tuVi - current.tuVi;
                    percent = need / total;
                  }

                  return Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: LinearPercentIndicator(
                      percent: percent <= 1 ? percent : 0,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
