import 'package:flutter/material.dart';
import 'package:flutter_destroyer/drawer/index.dart';
import 'package:flutter_destroyer/pages/soulLand/components/base.dart';
import 'package:flutter_destroyer/pages/soulLand/components/soul_land_bottom_navigation.dart';
import 'package:go_router/go_router.dart';

Widget _appBarLeading(BuildContext context) {
  return IconButton(
    onPressed: () => context.pop(),
    icon: const Icon(Icons.arrow_back),
  );
}

Scaffold scaffoldHandle(BuildContext context, Widget child, String path) {
  String title = "Trang chủ";

  bool? centerTitle;
  Widget? leading;
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
    if (path == "/manga") {
      title = "Truyện tranh";
    }

    if (path.contains("/detail")) {
      title = "Truyện tranh chi tiết";

      leading = _appBarLeading(context);
    }

    if (path.contains("/chapter")) {
      title = "Truyện tranh chương";

      // endDrawer = MangaChapterEndDrawer(
      //   detailId: detailId!,
      //   chapterId: chapterId!,
      //   chapters: model.chapters,
      // );
    }
  }

  if (path.contains("/soulland")) {
    title = "Idle";

    bottomNavigationBar = const SoulLandBottomNavigation();

    floatingActionButtonLocation = FloatingActionButtonLocation.miniStartFloat;

    floatingActionButton = const LuaChonTuLuyen();
  }

  return Scaffold(
    appBar: AppBar(
      title: Text(title),
      centerTitle: centerTitle,
      leading: leading,
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
      child: child,
    ),
  );
}
