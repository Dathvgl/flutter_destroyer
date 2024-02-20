import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/cubits/bottomIndexed/bottom_indexed_cubit.dart';
import 'package:flutter_destroyer/cubits/manga/manga_cubit.dart';
import 'package:flutter_destroyer/drawer/index.dart';
import 'package:flutter_destroyer/extensions/string.dart';
import 'package:flutter_destroyer/pages/manga/mangaChapter/manga_chapter_end_drawer.dart';
import 'package:flutter_destroyer/pages/soulLand/components/base.dart';
import 'package:flutter_destroyer/pages/soulLand/components/soul_land_bottom_navigation.dart';
import 'package:flutter_destroyer/pages/soulland/vohon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

Widget _appBarLeading(BuildContext context) {
  return IconButton(
    onPressed: () => context.pop(),
    icon: const Icon(Icons.arrow_back),
  );
}

Scaffold scaffoldHandle({
  required BuildContext context,
  required Widget child,
  required String path,
  Map<String, dynamic> param = const {},
}) {
  String title = "Trang chủ";
  Widget body = child;

  bool appbar = true;
  Color? backgroundColor;
  bool? centerTitle;
  Widget? leading;
  List<Widget>? actions;
  Widget? endDrawer;
  Widget? bottomNavigationBar;
  FloatingActionButtonLocation? floatingActionButtonLocation;
  Widget? floatingActionButton;

  if (path.contains("/auth")) {
    title = "Đăng nhập";

    centerTitle = true;

    leading = _appBarLeading(context);
  }

  if (path.contains("/setting")) {
    title = "Cài đặt";

    leading = _appBarLeading(context);
  }

  if (path.contains("/calculator")) {
    title = "Tính toán";
  }

  if (path.contains("/manga")) {
    body = BlocListener<MangaCubit, MangaState>(
      listenWhen: (previous, current) {
        return previous.type.name != current.type.name;
      },
      listener: (context, state) {
        Navigator.of(context).popUntil(ModalRoute.withName("/manga"));
      },
      child: child,
    );

    if (path == "/manga") {
      title = context.read<MangaCubit>().state.type.name.toCapitalized();
    }

    if (path.contains("/detail")) {
      // need real title
      title = "Truyện tranh chi tiết";

      leading = _appBarLeading(context);
    }

    if (path.contains("/chapter")) {
      appbar = false;

      endDrawer = MangaChapterEndDrawer(
        detailId: param["detailId"],
        chapterId: param["chapterId"],
      );
    }
  }

  if (path.contains("/soulland")) {
    final page = context.watch<BottomIndexedCubit>().state.page;
    final info = soulLandInfos[page];

    title = info["label"] as String;

    centerTitle = true;

    backgroundColor = info["backgroundColor"] as Color;

    if (page == 1) {
      actions = [
        Padding(
          padding: const EdgeInsets.only(
            right: 10.0,
          ),
          child: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const HuongDanVoHon(),
              );
            },
            icon: const FaIcon(
              FontAwesomeIcons.circleQuestion,
            ),
          ),
        )
      ];
    }

    bottomNavigationBar = const SoulLandBottomNavigation();

    floatingActionButtonLocation = FloatingActionButtonLocation.miniStartFloat;

    floatingActionButton = const LuaChonTuLuyen();
  }

  return Scaffold(
    appBar: appbar == false
        ? null
        : AppBar(
            title: Text(title),
            centerTitle: centerTitle,
            leading: leading,
            backgroundColor: backgroundColor,
            actions: actions,
            shape: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
    drawer: const DrawerRoot(),
    endDrawer: endDrawer,
    bottomNavigationBar: bottomNavigationBar,
    floatingActionButtonLocation: floatingActionButtonLocation,
    floatingActionButton: floatingActionButton,
    body: SafeArea(
      child: body,
    ),
  );
}
