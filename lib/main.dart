import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/blocs/auth/auth_bloc.dart';
import 'package:flutter_destroyer/blocs/user/user_bloc.dart';
import 'package:flutter_destroyer/cubits/bottomIndexed/bottom_indexed_cubit.dart';
import 'package:flutter_destroyer/cubits/calculator/calculator_cubit.dart';
import 'package:flutter_destroyer/cubits/cultivation/cultivation_cubit.dart';
import 'package:flutter_destroyer/cubits/mangaType/manga_type_cubit.dart';
import 'package:flutter_destroyer/cubits/theme/theme_cubit.dart';
import 'package:flutter_destroyer/cubits/userCultivation/user_cultivation_cubit.dart';
import 'package:flutter_destroyer/drawer/index.dart';
import 'package:flutter_destroyer/firebase_options.dart';
import 'package:flutter_destroyer/models/tuTien/tu_tien.dart';
import 'package:flutter_destroyer/pages/auth_page.dart';
import 'package:flutter_destroyer/pages/calculator/page.dart';
import 'package:flutter_destroyer/pages/home/page.dart';
import 'package:flutter_destroyer/pages/manga/mangaChapter/manga_chapter_page.dart';
import 'package:flutter_destroyer/pages/manga/mangaDetail/page.dart';
import 'package:flutter_destroyer/pages/manga/page.dart';
import 'package:flutter_destroyer/pages/setting_page.dart';
import 'package:flutter_destroyer/pages/soulLand/components/soul_land_body.dart';
import 'package:flutter_destroyer/resources/auth_repository.dart';
import 'package:flutter_destroyer/resources/user_repository.dart';
import 'package:flutter_destroyer/utils/scaffold.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // runApp(
  //   FutureBuilder(
  //     future: DbHelper.instance.getTuTiens(),
  //     builder: (context, snapshot) {
  //       if (!snapshot.hasData) {
  //         return const LoadingPage();
  //       }

  //       List<TuTien>? tutienList = snapshot.data as List<TuTien>?;
  //       if (tutienList!.isEmpty) {
  //         DbHelper.instance.add(TuTien());
  //         return init(TuTien());
  //       }

  //       return init(tutienList.last);
  //     },
  //   ),
  // );

  final tuTiens = await _initCultivation();

  runApp(MyApp(tuTiens: tuTiens));
}

Future<List<TuTienModel>> _initCultivation() async {
  final json = await rootBundle.loadString("assets/jsons/tuTien.json");
  return (jsonDecode(json) as List)
      .map((e) => TuTienModel.fromJson(e))
      .toList();
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  initialLocation: "/",
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        final path = state.fullPath;

        if (path != null) {
          return scaffoldHandle(context, child, path);
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("Trang chủ"),
            shape: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          drawer: const DrawerRoot(),
          body: SafeArea(
            child: child,
          ),
        );
      },
      routes: [
        GoRoute(
          path: "/",
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const HomePage(),
          routes: [
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: "auth",
              builder: (context, state) => const AuthPage(),
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: "setting",
              builder: (context, state) => const SettingPage(),
            ),
            GoRoute(
              path: "calculator",
              parentNavigatorKey: _shellNavigatorKey,
              builder: (context, state) => BlocProvider(
                create: (context) => CalculatorCubit(),
                child: const CalculatorPage(),
              ),
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: "manga",
              builder: (context, state) => const MangaPage(),
              routes: [
                GoRoute(
                  parentNavigatorKey: _shellNavigatorKey,
                  path: "detail/:id",
                  builder: (context, state) => MangaDetailPage(
                    id: state.pathParameters["id"],
                  ),
                ),
                GoRoute(
                  parentNavigatorKey: _shellNavigatorKey,
                  path: "chapter/:detailId/:chapterId",
                  builder: (context, state) => MangaChapterPage(
                    detailId: state.pathParameters["detailId"],
                    chapterId: state.pathParameters["chapterId"],
                  ),
                ),
              ],
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: "soulland",
              builder: (context, state) => const SoulLandBody(),
            ),
          ],
        ),
      ],
    )
  ],
);

class MyApp extends StatelessWidget {
  final List<TuTienModel> tuTiens;

  MyApp({
    super.key,
    required this.tuTiens,
  });

  // final _router = GoRouterDart.router;

  final _authRepository = AuthRepository();
  final _userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    _userRepository.tuTiens = tuTiens;

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => _authRepository),
        RepositoryProvider(create: (context) => _userRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeCubit()),
          BlocProvider(create: (context) => BottomIndexedCubit()),
          BlocProvider(create: (context) => CultivationCubit(tuTiens: tuTiens)),
          BlocProvider(create: (context) => MangaTypeCubit()),
          BlocProvider(create: (context) {
            return AuthBloc(authRepository: _authRepository);
          }),
          BlocProvider(create: (context) => UserBloc()),
          BlocProvider(create: (context) {
            return UserCultivationCubit(
              authRepository: _authRepository,
              userRepository: _userRepository,
            );
          }),
          // ChangeNotifierProvider(
          //   create: (_) => TuTien(),
          // )
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: "Flutter Destroyer",
              theme: state.useTheme,
              routerDelegate: _router.routerDelegate,
              routeInformationParser: _router.routeInformationParser,
              routeInformationProvider: _router.routeInformationProvider,
            );
          },
        ),
      ),
    );
  }
}
