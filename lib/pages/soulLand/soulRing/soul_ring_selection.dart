import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/cubits/soulLand/soul_land_cubit.dart';
import 'package:flutter_destroyer/models/soulLand/soulRing/spirit_soul.dart';
import 'package:flutter_destroyer/pages/soulLand/soulRing/soul_ring_selection_share.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class SoulRingSelection extends StatelessWidget {
  final ValueNotifier<bool> isDial = ValueNotifier(false);

  SoulRingSelection({super.key});

  void callbackDial() {
    isDial.value = false;
  }

  void customDialog(BuildContext context) {
    callbackDial();

    showDialog(
      context: context,
      builder: (_) => const SoulRingSelectionShare(),
    );
  }

  void initSoulRing(BuildContext context) {
    if (!context.read<SoulLandCubit>().state.soulPower.breakThrough) {
      return;
    }

    context.read<SoulLandCubit>().updateSoulPowerBreak();

    if (context.read<SoulLandCubit>().state.soulRing.spiritSouls.length + 1 >=
        SpiritSoul.nameCap.length) {
      return;
    }

    context.read<SoulLandCubit>().updateSpiritSoul();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            renderOverlay: false,
            closeManually: true,
            openCloseDial: isDial,
            children: [
              SpeedDialChild(
                onTap: () {
                  callbackDial();
                  initSoulRing(context);
                },
                child: const Icon(Icons.add),
                backgroundColor: Colors.red,
              ),
              SpeedDialChild(
                onTap: () => customDialog(context),
                child: const Icon(Icons.rule),
                backgroundColor: Colors.amber,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
