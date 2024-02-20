import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/cubits/manga/manga_cubit.dart';
import 'package:flutter_destroyer/cubits/theme/theme_cubit.dart';
import 'package:flutter_destroyer/cubits/user/user_cubit.dart';
import 'package:flutter_destroyer/extensions/double.dart';
import 'package:flutter_destroyer/models/manga/manga_chapter_image.dart';
import 'package:flutter_destroyer/models/manga/manga_user_follow.dart';
import 'package:go_router/go_router.dart';

class MangaChapterItem extends StatefulWidget {
  final String detailId;
  final MangaChapterImageModel data;

  const MangaChapterItem({
    super.key,
    required this.detailId,
    required this.data,
  });

  @override
  State<MangaChapterItem> createState() => _MangaChapterItemState();
}

class _MangaChapterItemState extends State<MangaChapterItem> {
  final _controller = ScrollController();
  final _heightBar = AppBar().preferredSize.height;

  final _visible = ValueNotifier<bool>(true);
  final _scroll = ValueNotifier<bool>(true);

  late final List<MangaChapterCurrentImageModel> _images;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      final scrollOffset = _controller.offset;
      final maxScrollHeight = _controller.position.maxScrollExtent;

      if (scrollOffset > _heightBar &&
          scrollOffset < maxScrollHeight - _heightBar) {
        _visible.value = false;
        _scroll.value = false;
      }

      if (scrollOffset <= _heightBar ||
          scrollOffset >= maxScrollHeight - _heightBar) {
        _visible.value = true;
        _scroll.value = true;
      }
    });

    final cubit = context.read<UserCubit>();

    if (cubit.state.cultivation != null) {
      cubit.updateCultivation(
        idCanhGioi: cubit.state.cultivation!.idCanhGioi,
        tuVi: cubit.state.cultivation!.tuVi,
        tuViTheo: 1,
      );
    }

    _images = widget.data.current?.chapters ?? [];
  }

  @override
  void dispose() {
    _visible.dispose();
    _controller.dispose();
    super.dispose();
  }

  Widget header({
    required String detailId,
    required MangaChapterImageModel data,
  }) {
    return Positioned(
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: _heightBar,
            color: state.theme ? Colors.black : Colors.white,
            child: Row(
              children: [
                InkWell(
                  onTap: () => context.pop(),
                  child: const Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: Text(
                    data.current?.chapter.chapterManga(true) ??
                        "Chapter không có",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 32),
                InkWell(
                  onTap: () =>
                      context.pushReplacement("/manga/detail/$detailId"),
                  child: const Icon(Icons.info),
                ),
                const SizedBox(width: 16),
                InkWell(
                  onTap: () => Scaffold.of(context).openEndDrawer(),
                  child: const Icon(Icons.list),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget footer({
    MangaUserFollow? follow,
    required String detailId,
    required MangaChapterImageModel data,
  }) {
    return Positioned(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: _heightBar,
              color: state.theme ? Colors.black : Colors.white,
              child: Row(
                children: [
                  TextButton(
                    onPressed: data.canPrev == null
                        ? null
                        : () => context.pushReplacement(
                            "/manga/chapter/$detailId/${data.canPrev?.id}"),
                    child: const Text(
                      "Chapter trước",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: data.canNext == null
                        ? null
                        : () => context.pushReplacement(
                            "/manga/chapter/$detailId/${data.canNext?.id}"),
                    child: const Text(
                      "Chapter sau",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.maxFinite,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (!_scroll.value) {
                _visible.value = !_visible.value;
              }
            },
            child: ListView(
              controller: _controller,
              children: [
                SizedBox(
                  height: AppBar().preferredSize.height,
                ),
                ..._images.map(
                  (item) {
                    return CachedNetworkImage(
                      imageUrl: item.src,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) {
                        return Center(
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                          ),
                        );
                      },
                      errorWidget: (context, url, error) => Container(
                        height: 50,
                        color: Colors.red.shade800,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: AppBar().preferredSize.height,
                ),
              ],
            ),
          ),
          ValueListenableBuilder(
            valueListenable: _visible,
            builder: (BuildContext context, value, Widget? child) {
              return Visibility(
                visible: value,
                child: header(
                  detailId: widget.detailId,
                  data: widget.data,
                ),
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: _visible,
            builder: (BuildContext context, value, Widget? child) {
              return BlocBuilder<MangaCubit, MangaState>(
                builder: (context, state) {
                  return Visibility(
                    visible: value,
                    child: footer(
                      detailId: widget.detailId,
                      data: widget.data,
                      follow: state.userFollow,
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
