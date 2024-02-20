import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/cubits/bottomIndexed/bottom_indexed_cubit.dart';
import 'package:flutter_destroyer/cubits/calculator/calculator_cubit.dart';
import 'package:flutter_destroyer/cubits/cultivation/cultivation_cubit.dart';
import 'package:flutter_destroyer/cubits/manga/manga_cubit.dart';
import 'package:flutter_destroyer/cubits/theme/theme_cubit.dart';
import 'package:flutter_destroyer/cubits/user/user_cubit.dart';
import 'package:flutter_destroyer/firebase_options.dart';
import 'package:flutter_destroyer/models/fetch_handle.dart';
import 'package:flutter_destroyer/models/soulland/tutiens.dart';
import 'package:flutter_destroyer/models/tuTien/tu_tien.dart';
import 'package:flutter_destroyer/pages/auth_page.dart';
import 'package:flutter_destroyer/pages/calculator/page.dart';
import 'package:flutter_destroyer/pages/home/page.dart';
import 'package:flutter_destroyer/pages/manga/mangaChapter/page.dart';
import 'package:flutter_destroyer/pages/manga/mangaDetail/page.dart';
import 'package:flutter_destroyer/pages/manga/page.dart';
import 'package:flutter_destroyer/pages/setting_page.dart';
import 'package:flutter_destroyer/pages/soulLand/components/soul_land_body.dart';
import 'package:flutter_destroyer/repositories/auth_repository.dart';
import 'package:flutter_destroyer/repositories/user_repository.dart';
import 'package:flutter_destroyer/utils/scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/* 
flutter run --web-port 3000
 */

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FetchHandle().cookie();

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
          BlocProvider(create: (context) => ThemeCubit()),
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
          MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => TuTien(),
              ),
            ],
          ),
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
