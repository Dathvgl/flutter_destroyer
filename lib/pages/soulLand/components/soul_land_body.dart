import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/cubits/bottomIndexed/bottom_indexed_cubit.dart';
import 'package:flutter_destroyer/pages/soulland/congphap.dart';
import 'package:flutter_destroyer/pages/soulland/honhoan.dart';
import 'package:flutter_destroyer/pages/soulland/tuluyen.dart';
import 'package:flutter_destroyer/pages/soulland/vohon.dart';

final _tabPages = [
  const CongPhapPage(),
  const VoHonPage(),
  const TuLuyenPage(),
  const HonHoanPage(),
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
