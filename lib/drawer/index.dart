import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/blocs/auth/auth_bloc.dart';
import 'package:flutter_destroyer/cubits/theme/theme_cubit.dart';
import 'package:flutter_destroyer/drawer/drawer_content.dart';
import 'package:flutter_destroyer/drawer/drawer_footer.dart';
import 'package:flutter_destroyer/drawer/drawer_header.dart';
import 'package:flutter_destroyer/enum.dart';
import 'package:flutter_destroyer/models/user/user.dart';

class DrawerRootInherited extends InheritedWidget {
  final UserModel user;
  final AuthStatus authStatus;

  const DrawerRootInherited({
    super.key,
    required this.user,
    required this.authStatus,
    required super.child,
  });

  static DrawerRootInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DrawerRootInherited>();
  }

  @override
  bool updateShouldNotify(DrawerRootInherited oldWidget) {
    return authStatus != oldWidget.authStatus;
  }
}

class DrawerRoot extends StatelessWidget {
  const DrawerRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          state.user;
          return DrawerRootInherited(
            user: state.status == AuthStatus.authenticated
                ? state.user
                : UserModel.empty,
            authStatus: state.status,
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
    );
  }
}
