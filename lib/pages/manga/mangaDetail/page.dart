import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/components/shimmer.dart';
import 'package:flutter_destroyer/cubits/manga/manga_cubit.dart';
import 'package:flutter_destroyer/cubits/user/user_cubit.dart';
import 'package:flutter_destroyer/models/manga/manga_detail.dart';
import 'package:flutter_destroyer/pages/manga/mangaDetail/manga_detail_item.dart';
import 'package:flutter_destroyer/utils/await_builder.dart';

class MangaDetailInherited extends InheritedWidget {
  final String id;
  final MangaDetailModel data;

  const MangaDetailInherited({
    super.key,
    required super.child,
    required this.id,
    required this.data,
  });

  static MangaDetailInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MangaDetailInherited>();
  }

  @override
  bool updateShouldNotify(MangaDetailInherited oldWidget) {
    return false;
  }
}

class MangaDetailPage extends StatelessWidget {
  final String? id;

  const MangaDetailPage({
    super.key,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    if (id == null) {
      return const Center(
        child: Text(
          "Manga not found",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return awaitFuture(
      future: context.read<MangaCubit>().getMangaDetail(id: id!),
      wait: const Padding(
        padding: EdgeInsets.all(16),
        child: CustomShimmer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomShimmerLine(),
              SizedBox(height: 10),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomShimmerBox(),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomShimmerLine(),
                          SizedBox(height: 10),
                          CustomShimmerLine(),
                          SizedBox(height: 10),
                          CustomShimmerLine(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              CustomShimmerBox(),
            ],
          ),
        ),
      ),
      done: (context, data) {
        if (data == null) {
          return const SizedBox();
        }

        return BlocBuilder<UserCubit, UserState>(
          buildWhen: (previous, current) {
            return previous.user != current.user;
          },
          builder: (context, state) {
            context.read<MangaCubit>().getMangaUserFollow(id: id!);

            return MangaDetailInherited(
              id: id!,
              data: data,
              child: const MangaDetailItem(),
            );
          },
        );
      },
    );
  }
}
