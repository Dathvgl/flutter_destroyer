import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/components/shimmer.dart';
import 'package:flutter_destroyer/cubits/manga/manga_cubit.dart';
import 'package:flutter_destroyer/cubits/theme/theme_cubit.dart';
import 'package:flutter_destroyer/pages/manga/mangaChapter/manga_chapter_item.dart';
import 'package:flutter_destroyer/utils/await_builder.dart';
import 'package:go_router/go_router.dart';

class MangaChapterPage extends StatelessWidget {
  final String? detailId;
  final String? chapterId;

  const MangaChapterPage({
    super.key,
    this.detailId,
    this.chapterId,
  });

  @override
  Widget build(BuildContext context) {
    if (detailId == null || chapterId == null) {
      return const Center(
        child: Text("Truyện không tồn tại"),
      );
    }

    return awaitFuture(
      future: context
          .read<MangaCubit>()
          .getMangaChapterImage(detailId: detailId!, chapterId: chapterId!),
      wait: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  height: AppBar().preferredSize.height,
                  color: state.theme ? Colors.black : Colors.white,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => context.pop(),
                        child: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(width: 32),
                      const Expanded(
                        child: Text(
                          "Loading...",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            ListView.separated(
              primary: false,
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
              itemCount: 5,
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: CustomShimmerBox(),
                );
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      done: (context, data) {
        if (data == null) {
          return const SizedBox();
        }

        final cubit = context.read<MangaCubit>();
        final follow = cubit.state.userFollow;

        if (follow != null) {
          cubit.putMangaUserFollow(
            detailId: detailId!,
            chapterId: chapterId!,
          );
        }

        return MangaChapterItem(
          detailId: detailId!,
          data: data,
        );
      },
    );
  }
}
