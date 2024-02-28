import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/cubits/soulLand/soul_land_cubit.dart';
import 'package:flutter_destroyer/models/soulLand/soulRing/spirit_soul.dart';
import 'package:flutter_destroyer/pages/soulLand/soulRing/soul_ring_selection_spirit.dart';

class SoulRingSelectionShare extends StatelessWidget {
  const SoulRingSelectionShare({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> listTiles() {
      List<Widget> widgets = <Widget>[];

      List<SpiritSoul> spiritSouls =
          context.read<SoulLandCubit>().state.soulRing.spiritSouls;

      int n = spiritSouls.length;

      for (var i = 0; i < n; i++) {
        if (i != 0 || i == n - 1) {
          widgets.add(const Divider(
            thickness: 2,
            color: Colors.black,
          ));
        }

        widgets.add(SoulRingSelectionSpirit(
          index: i,
          spiritSoul: spiritSouls[i],
        ));
      }

      return widgets;
    }

    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Phân tu hồn hoàn",
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ...listTiles()
          ],
        ),
      ),
    );
  }
}
