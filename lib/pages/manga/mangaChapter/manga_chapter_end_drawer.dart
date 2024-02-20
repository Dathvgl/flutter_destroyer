import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/cubits/manga/manga_cubit.dart';
import 'package:flutter_destroyer/cubits/theme/theme_cubit.dart';
import 'package:flutter_destroyer/extensions/double.dart';
import 'package:flutter_destroyer/models/manga/manga_chapter.dart';
import 'package:flutter_destroyer/models/manga/manga_user_follow.dart';
import 'package:flutter_destroyer/utils/await_builder.dart';
import 'package:go_router/go_router.dart';

class MangaChapterEndDrawer extends StatelessWidget {
  final String detailId;
  final String chapterId;

  const MangaChapterEndDrawer({
    super.key,
    required this.detailId,
    required this.chapterId,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: awaitFuture(
          future: context.read<MangaCubit>().getMangaChapter(id: detailId),
          done: (context, data) {
            return MangaChapterEndDrawerItem(
              detailId: detailId,
              chapterId: chapterId,
              chapters: data,
            );
          },
        ),
      ),
    );
  }
}

class MangaChapterEndDrawerItem extends StatelessWidget {
  final String detailId;
  final String chapterId;
  final MangaUserFollow? follow;
  final List<MangaChapterModel> chapters;

  const MangaChapterEndDrawerItem({
    super.key,
    required this.detailId,
    required this.chapterId,
    this.follow,
    required this.chapters,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.watch<ThemeCubit>().state.useTheme.scaffoldBackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Danh sách",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Divider(
              height: 0,
              thickness: 6,
              color: Colors.blue,
            ),
            ListView.separated(
              primary: false,
              shrinkWrap: true,
              separatorBuilder: (context, index) => const Divider(
                height: 0,
                thickness: 3,
              ),
              itemCount: chapters.length,
              itemBuilder: (context, index) {
                final item = chapters[index];
                final isFocused = chapterId == item.id;

                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  color: isFocused
                      ? Theme.of(context).colorScheme.inversePrimary
                      : null,
                  child: Wrap(
                    spacing: 10,
                    runAlignment: WrapAlignment.center,
                    children: [
                      InkWell(
                        onTap: isFocused
                            ? null
                            : () => context.pushReplacement(
                                "/manga/chapter/$detailId/${item.id}"),
                        child: Text(
                          item.chapter.chapterManga(true),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      if (follow != null) ...[
                        if (follow?.lastestChapterId == item.id) ...[
                          const Icon(Icons.star, color: Colors.red),
                        ],
                        if (follow?.currentChapterId == item.id &&
                            follow?.lastestChapterId != item.id) ...[
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ],
                      ],
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
