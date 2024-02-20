import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/cubits/manga/manga_cubit.dart';
import 'package:flutter_destroyer/extensions/int.dart';
import 'package:flutter_destroyer/models/manga/manga_detail.dart';
import 'package:flutter_destroyer/pages/manga/components/manga_thumnail.dart';
import 'package:flutter_destroyer/pages/manga/mangaDetail/manga_detail_follow.dart';
import 'package:flutter_destroyer/pages/manga/mangaDetail/manga_detail_tab.dart';
import 'package:flutter_destroyer/pages/manga/mangaDetail/page.dart';
import 'package:go_router/go_router.dart';

class MangaDetailItem extends StatelessWidget {
  const MangaDetailItem({super.key});

  List<Widget> info(String mangaId, MangaDetailModel data) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            data.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: MangaThumnail(
                    id: data.id,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    runSpacing: 12,
                    children: [
                      if (data.altTitle != null) ...[
                        Row(
                          children: [
                            const Icon(Icons.auto_stories),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "${data.altTitle}\n",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (data.authors.isNotEmpty) ...[
                        Row(
                          children: [
                            const Icon(Icons.person),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                data.authors.map((e) => e.name).join(", "),
                              ),
                            ),
                          ],
                        ),
                      ],
                      Row(
                        children: [
                          const Icon(Icons.menu_book),
                          const SizedBox(width: 12),
                          Text(data.status),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.screenshot_monitor),
                          const SizedBox(width: 12),
                          Text(data.watched.humanCompact()),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.check_circle),
                          const SizedBox(width: 12),
                          Text(data.followed.humanCompact()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Wrap(
          spacing: 8,
          children: data.tags.map((e) {
            return ActionChip(
              label: Text(e.name),
              labelPadding: const EdgeInsets.symmetric(
                horizontal: 2,
              ),
              onPressed: () {},
            );
          }).toList(),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Wrap(
            spacing: 16,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "Đọc từ đầu",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "Đọc mới nhất",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const MangaDetailFollow(),
              BlocBuilder<MangaCubit, MangaState>(
                buildWhen: (previous, current) {
                  return previous.userFollow != current.userFollow;
                },
                builder: (context, state) {
                  if (state.userFollow == null) {
                    return const SizedBox();
                  }

                  return InkWell(
                    onTap: () => context.push(
                        "/manga/chapter/$mangaId/${state.userFollow?.currentChapterId}"),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final inherited = MangaDetailInherited.of(context);

    if (inherited == null) {
      return const SizedBox();
    }

    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  ...info(inherited.id, inherited.data),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SegmentedTabControl(
                      selectedTabTextColor: Colors.white70,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                      tabs: const [
                        SegmentTab(
                          label: "Description",
                          color: Colors.blue,
                          textColor: Colors.black,
                        ),
                        SegmentTab(
                          label: "Chapters",
                          color: Colors.green,
                          textColor: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(
                    height: 0,
                    thickness: 3,
                    color: Colors.blue,
                  ),
                ],
              ),
            )
          ];
        },
        body: const MangaDetailItemTabView(),
      ),
    );
  }
}
