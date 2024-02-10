import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/drawer/index.dart';
import 'package:flutter_destroyer/screens/calculator/cubit/calculator_cubit.dart';
import 'package:flutter_destroyer/screens/calculator/page.dart';
import 'package:flutter_destroyer/screens/home/page.dart';
import 'package:go_router/go_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  initialLocation: "/calculator",
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        String title = "Home Screen";

        switch (state.matchedLocation) {
          case "/calculator":
            title = "Calculator Screen";
            break;
          case "/":
          case "/home":
          default:
            title = "Home Screen";
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(title),
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
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              path: "calculator",
              parentNavigatorKey: _shellNavigatorKey,
              builder: (context, state) => BlocProvider(
                create: (context) => CalculatorCubit(),
                child: const CalculatorScreen(),
              ),
            ),
          ],
        ),
      ],
    )
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Flutter Destroyer",
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}
