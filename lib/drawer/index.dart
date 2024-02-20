import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/cubits/theme/theme_cubit.dart';
import 'package:flutter_destroyer/cubits/user/user_cubit.dart';
import 'package:flutter_destroyer/drawer/drawer_content.dart';
import 'package:flutter_destroyer/drawer/drawer_footer.dart';
import 'package:flutter_destroyer/drawer/drawer_header.dart';
import 'package:flutter_destroyer/models/user/user.dart';

class DrawerRootInherited extends InheritedWidget {
  final UserModel? user;

  const DrawerRootInherited({
    super.key,
    required this.user,
    required super.child,
  });

  static DrawerRootInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DrawerRootInherited>();
  }

  @override
  bool updateShouldNotify(DrawerRootInherited oldWidget) {
    return user != oldWidget.user;
  }
}

class DrawerRoot extends StatelessWidget {
  const DrawerRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: BlocBuilder<UserCubit, UserState>(
          // buildWhen: (previous, current) {
          //   print("hahaha ${previous.user} ||| ${current.user}");
          //   return previous.user != current.user;
          // },
          builder: (context, state) {
            return DrawerRootInherited(
              user: state.user,
              child: BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  return Container(
                    color: state.useTheme.scaffoldBackgroundColor,
                    child: const Column(
                      children: [
                        DrawerRootHeader(),
                        DrawerRootContent(),
                        Divider(
                          height: 0,
                          thickness: 1,
                        ),
                        DrawerRootFooter(),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
