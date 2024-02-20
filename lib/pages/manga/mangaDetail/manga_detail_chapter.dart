import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/components/shimmer.dart';
import 'package:flutter_destroyer/cubits/manga/manga_cubit.dart';
import 'package:flutter_destroyer/extensions/double.dart';
import 'package:flutter_destroyer/extensions/int.dart';
import 'package:flutter_destroyer/models/manga/manga_chapter.dart';
import 'package:flutter_destroyer/models/manga/manga_user_follow.dart';
import 'package:flutter_destroyer/pages/manga/mangaDetail/page.dart';
import 'package:flutter_destroyer/utils/await_builder.dart';
import 'package:go_router/go_router.dart';

class MangaDetailChapter extends StatefulWidget {
  const MangaDetailChapter({super.key});

  @override
  State<MangaDetailChapter> createState() => _MangaDetailChapterState();
}

class _MangaDetailChapterState extends State<MangaDetailChapter>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final inherited = MangaDetailInherited.of(context);

    if (inherited == null) {
      return const SizedBox();
    }

    return awaitFuture(
      future: context.read<MangaCubit>().getMangaChapter(id: inherited.id),
      wait: const CustomShimmer(
        child: CustomShimmerBox(),
      ),
      done: (context, data) {
        return BlocBuilder<MangaCubit, MangaState>(
          buildWhen: (previous, current) {
            return previous.userFollow != current.userFollow;
          },
          builder: (context, state) {
            return MangaDetailChapterInfo(
              follow: state.userFollow,
              data: data,
            );
          },
        );
      },
    );
  }
}

class MangaDetailChapterInfo extends StatelessWidget {
  final MangaUserFollow? follow;
  final List<MangaChapterModel> data;

  const MangaDetailChapterInfo({
    super.key,
    this.follow,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final inherited = MangaDetailInherited.of(context);

    if (inherited == null) {
      return const SizedBox();
    }

    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      separatorBuilder: (context, index) => const Divider(
        height: 0,
        thickness: 3,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 10,
                  runAlignment: WrapAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => context
                          .push("/manga/chapter/${inherited.id}/${item.id}"),
                      child: Text(
                        item.chapter.chapterManga(true),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.watched.humanCompact()),
                    Text(
                      item.time.timestampMilli(),
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
