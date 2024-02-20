import 'package:flutter/material.dart';
import 'package:flutter_destroyer/pages/manga/mangaDetail/manga_detail_chapter.dart';
import 'package:flutter_destroyer/pages/manga/mangaDetail/page.dart';

class MangaDetailItemTabView extends StatefulWidget {
  const MangaDetailItemTabView({super.key});

  @override
  State<MangaDetailItemTabView> createState() => _MangaDetailItemTabViewState();
}

class _MangaDetailItemTabViewState extends State<MangaDetailItemTabView>
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

    return TabBarView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            inherited.data.description,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const MangaDetailChapter(),
      ],
    );
  }
}
