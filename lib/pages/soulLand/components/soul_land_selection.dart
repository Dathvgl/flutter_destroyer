import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/cubits/soulLand/soul_land_cubit.dart';
import 'package:flutter_destroyer/pages/soulLand/components/soul_land_energy_share.dart';
import 'package:flutter_destroyer/pages/soulLand/components/soul_land_reset.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class SoulLandSelection extends StatelessWidget {
  final ValueNotifier<bool> _isDial = ValueNotifier(false);

  SoulLandSelection({super.key});

  void callbackDial() {
    _isDial.value = false;
  }

  void stateCultivate(BuildContext context) {
    if (context.read<SoulLandCubit>().state.martialSoul.name == "") {
      return;
    }

    context.read<SoulLandCubit>().updateIsCultivate();
  }

  void customDialog(BuildContext context) {
    callbackDial();

    showDialog(
      context: context,
      builder: (_) => const SoulLandEnergyShare(),
    );
  }

  void resetDialog(BuildContext context) {
    callbackDial();

    showDialog(
      context: context,
      builder: (_) => const SoulLandReset(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Timer? timeCultivate;

    void gainEnergy(bool state) {
      if (!state) {
        timeCultivate?.cancel();
        timeCultivate = null;
      } else {
        const interval = Duration(milliseconds: 50);
        timeCultivate = Timer.periodic(interval, (Timer t) {
          if (!state) {
            return;
          }

          context.read<SoulLandCubit>().updateEnergy();
          context.read<SoulLandCubit>().updateMartialSoulQuality();
        });
      }
    }

    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      renderOverlay: false,
      closeManually: true,
      openCloseDial: _isDial,
      children: [
        SpeedDialChild(
          child: BlocBuilder<SoulLandCubit, SoulLandState>(
            buildWhen: (previous, current) {
              return previous.isCultivate != current.isCultivate;
            },
            builder: (context, state) {
              gainEnergy(state.isCultivate);

              return FloatingActionButton(
                onPressed: () => stateCultivate(context),
                child: state.isCultivate
                    ? const Icon(Icons.pause)
                    : const Icon(Icons.play_arrow),
              );
            },
          ),
          backgroundColor: Colors.blue,
        ),
        SpeedDialChild(
          onTap: () => customDialog(context),
          child: const Icon(Icons.settings),
          backgroundColor: Colors.blue,
        ),
        SpeedDialChild(
          onTap: () => resetDialog(context),
          child: const Icon(Icons.close),
          backgroundColor: Colors.blue,
        ),
      ],
    );
  }
}
