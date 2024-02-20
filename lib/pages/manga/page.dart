import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/components/shimmer.dart';
import 'package:flutter_destroyer/cubits/manga/manga_cubit.dart';
import 'package:flutter_destroyer/extensions/double.dart';
import 'package:flutter_destroyer/extensions/int.dart';
import 'package:flutter_destroyer/models/manga/manga_list.dart';
import 'package:flutter_destroyer/pages/manga/components/manga_dialog.dart';
import 'package:flutter_destroyer/pages/manga/components/manga_thumnail.dart';
import 'package:flutter_destroyer/utils/await_builder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

class MangaPage extends StatelessWidget {
  const MangaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return awaitFuture(
      future: context.read<MangaCubit>().getMangaList(),
      wait: AlignedGridView.count(
        padding: const EdgeInsets.all(20),
        mainAxisSpacing: 20,
        crossAxisSpacing: 16,
        crossAxisCount: 2,
        itemCount: 10,
        itemBuilder: (context, index) {
          return const CustomShimmer(
            child: Column(
              children: [
                CustomShimmerBox(),
                SizedBox(height: 10),
                CustomShimmerLine(),
                SizedBox(height: 10),
                CustomShimmerLine(),
              ],
            ),
          );
        },
      ),
      done: (context, data) {
        if (data == null) {
          return const SizedBox();
        }

        return MangaList(
          data: data,
        );
      },
    );
  }
}

class MangaList extends StatelessWidget {
  final MangaListModel data;

  const MangaList({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return AlignedGridView.count(
      padding: const EdgeInsets.all(20),
      mainAxisSpacing: 20,
      crossAxisSpacing: 16,
      crossAxisCount: 2,
      itemCount: data.data.length,
      itemBuilder: (context, index) {
        final item = data.data[index];
        return MangaItem(item: item);
      },
    );
  }
}

class MangaItem extends StatelessWidget {
  final MangaListDetailModel item;

  const MangaItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => context.push("/manga/detail/${item.id}"),
              onLongPress: () => showDialog(
                context: context,
                builder: (context) => MangaDialog(item: item),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MangaThumnail(
                    id: item.id,
                    height: 150,
                    fit: BoxFit.fitWidth,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    child: Text(
                      "${item.title}\n",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
                left: 8,
                right: 8,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: item.chapters.map((e) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          context.push("/manga/chapter/${item.id}/${e.id}");
                        },
                        child: Text(
                          e.chapter.chapterManga(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        e.time.timestampMilli(full: false),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
