import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/cubits/soulLand/soul_land_cubit.dart';
import 'package:hive/hive.dart';
import 'package:universal_html/html.dart';

class HandleState extends StatefulWidget {
  final Widget child;

  const HandleState({
    super.key,
    required this.child,
  });

  @override
  State<HandleState> createState() => _HandleStateState();
}

class _HandleStateState extends State<HandleState> with WidgetsBindingObserver {
  late LazyBox soulLandLazyBox;

  Future<void> init() async {
    if (kIsWeb) {
      window.addEventListener("focus", onFocus);
      window.addEventListener("blur", onBlur);

      window.onBeforeUnload.listen((event) async {
        window.removeEventListener("focus", onFocus);
        window.removeEventListener("blur", onBlur);

        await soulLandDispose();

        Hive.close();
      });
    } else {
      WidgetsBinding.instance.addObserver(this);
    }

    soulLandLazyBox = await Hive.openLazyBox("soulLands");

    final LinkedHashMap? linkedHashMap = await soulLandLazyBox.get(
      "main",
      defaultValue: {},
    );

    final Map<String, dynamic> map = jsonDecode(jsonEncode(linkedHashMap));

    if (mounted) {
      context.read<SoulLandCubit>().fromMap(map);
    }
  }

  void onFocus(Event e) {
    didChangeAppLifecycleState(AppLifecycleState.resumed);
  }

  void onBlur(Event e) {
    didChangeAppLifecycleState(AppLifecycleState.paused);
  }

  Future<void> soulLandDispose() async {
    await soulLandLazyBox.put(
      "main",
      context.read<SoulLandCubit>().toMap(),
    );
  }

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    Hive.close();

    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      // Focus & visible
      case AppLifecycleState.resumed:
        break;
      // Not focus & partial visible
      case AppLifecycleState.inactive:
        break;
      // Not focus & not visible
      case AppLifecycleState.paused:
        await soulLandDispose();

        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
