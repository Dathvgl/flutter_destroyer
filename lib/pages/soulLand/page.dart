import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/cubits/bottomIndexed/bottom_indexed_cubit.dart';
import 'package:flutter_destroyer/pages/soulLand/cultivate/page.dart';
import 'package:flutter_destroyer/pages/soulLand/martialSoul/page.dart';
import 'package:flutter_destroyer/pages/soulLand/soulRing/page.dart';
import 'package:flutter_destroyer/pages/soulLand/technique/page.dart';

final _tabPages = [
  const TechniquePage(),
  const MartialSoulPage(),
  const CultivatePage(),
  const SoulRingPage(),
  // const HonCotPage(),
];

class SoulLandBody extends StatelessWidget {
  const SoulLandBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomIndexedCubit, BottomIndexedState>(
      builder: (context, state) {
        return IndexedStack(
          index: state.page,
          children: _tabPages,
        );
      },
    );
  }
}
