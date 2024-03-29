import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/cubits/bottomIndexed/bottom_indexed_cubit.dart';
import 'package:flutter_destroyer/cubits/calculator/calculator_cubit.dart';
import 'package:flutter_destroyer/cubits/cultivation/cultivation_cubit.dart';
import 'package:flutter_destroyer/cubits/manga/manga_cubit.dart';
import 'package:flutter_destroyer/cubits/soulLand/soul_land_cubit.dart';
import 'package:flutter_destroyer/cubits/theme/theme_cubit.dart';
import 'package:flutter_destroyer/cubits/user/user_cubit.dart';
import 'package:flutter_destroyer/firebase_options.dart';
import 'package:flutter_destroyer/models/fetch_handle.dart';
import 'package:flutter_destroyer/models/tuTien/tu_tien.dart';
import 'package:flutter_destroyer/pages/auth_page.dart';
import 'package:flutter_destroyer/pages/calculator/page.dart';
import 'package:flutter_destroyer/pages/home/page.dart';
import 'package:flutter_destroyer/pages/manga/mangaChapter/page.dart';
import 'package:flutter_destroyer/pages/manga/mangaDetail/page.dart';
import 'package:flutter_destroyer/pages/manga/page.dart';
import 'package:flutter_destroyer/pages/setting_page.dart';
import 'package:flutter_destroyer/pages/soulLand/page.dart';
import 'package:flutter_destroyer/repositories/auth_repository.dart';
import 'package:flutter_destroyer/repositories/user_repository.dart';
import 'package:flutter_destroyer/utils/handle_state.dart';
import 'package:flutter_destroyer/utils/scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

/* 
flutter run --web-port 3000
 */

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox("settings");

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FetchHandle().cookie();

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
        return scaffoldHandle(
          context: context,
          child: child,
          path: state.fullPath ?? "/",
          param: state.pathParameters,
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
          BlocProvider(create: (context) {
            return ThemeCubit(
              theme: Hive.box("settings").get(
                "theme",
                defaultValue: false,
              ) as bool,
            );
          }),
          BlocProvider(create: (context) => BottomIndexedCubit()),
          BlocProvider(create: (context) {
            return UserCubit(
              userRepository: _userRepository,
            );
          }),
          BlocProvider(create: (context) {
            return CultivationCubit(
              tuTiens: tuTiens,
            );
          }),
          BlocProvider(create: (context) => MangaCubit()),
          BlocProvider(create: (context) => SoulLandCubit()),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return HandleState(
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: "Flutter Destroyer",
                theme: state.useTheme,
                routerDelegate: _router.routerDelegate,
                routeInformationParser: _router.routeInformationParser,
                routeInformationProvider: _router.routeInformationProvider,
              ),
            );
          },
        ),
      ),
    );
  }
}
