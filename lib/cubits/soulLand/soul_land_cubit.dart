// ignore_for_file: depend_on_referenced_packages

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_destroyer/components/function.dart';
import 'package:flutter_destroyer/models/soulLand/martialSoul/index.dart';
import 'package:flutter_destroyer/models/soulLand/soulRing/index.dart';
import 'package:flutter_destroyer/models/soulLand/soulRing/spirit_soul.dart';
import 'package:flutter_destroyer/models/soulLand/soul_power.dart';
import 'package:flutter_destroyer/models/soulLand/spiritual_power.dart';
import 'package:flutter_destroyer/models/soulLand/technique/index.dart';
import 'package:flutter_destroyer/models/soulLand/technique/mysterious_heaven_technique.dart';
import 'package:flutter_destroyer/models/soulLand/technique/purple_demon_eyes.dart';

part 'soul_land_state.dart';

const _energyShare = [
  0.0,
  0.0,
  0.0,
  0.0,
];

class SoulLandCubit extends Cubit<SoulLandState> {
  SoulLandCubit()
      : super(SoullandInitial(
          martialSoul: MartialSoul(),
          soulPower: SoulPower(),
          spiritualPower: SpiritualPower(),
          soulRing: SoulRing(),
          technique: Technique(),
        ));

  void reset() {
    emit(SoullandInitial(
      martialSoul: MartialSoul(),
      soulPower: SoulPower(),
      spiritualPower: SpiritualPower(),
      soulRing: SoulRing(),
      technique: Technique(),
      isCultivate: state.isCultivate,
      energyShare: _energyShare,
    ));
  }

  void fromMap(Map<String, dynamic> map) {
    if (map.isNotEmpty) {
      emit(SoullandInitial(
        martialSoul: MartialSoul.fromMap(map["martialSoul"]),
        soulPower: SoulPower.fromMap(map["soulPower"]),
        spiritualPower: SpiritualPower.fromMap(map["spiritualPower"]),
        soulRing: SoulRing.fromMap(map["soulRing"]),
        technique: Technique.fromMap(map["technique"]),
        isCultivate: false,
        energyShare: const [0.0, 0.0, 0.0, 0.0],
      ));
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "martialSoul": state.martialSoul.toMap(),
      "soulPower": state.soulPower.toMap(),
      "spiritualPower": state.spiritualPower.toMap(),
      "soulRing": state.soulRing.toMap(),
      "technique": state.technique.toMap(),
    };
  }

  void updateEnergy() {
    SoulPower soulPower = SoulPower.cloneWith(state.soulPower);
    SpiritualPower spiritualPower =
        SpiritualPower.cloneWith(state.spiritualPower);
    Technique technique = Technique.cloneWith(state.technique);
    SoulRing soulRing = SoulRing.cloneWith(state.soulRing);

    double energy = state.energyBase +
        state.energyBase *
            (state.technique.multiplier +
                state.technique.tangSectTechniques[PurpleDemonEyes.unique]
                    .multiplier) +
        state.soulRing.multiplier;

    energy *= (5 +
        state.technique.tangSectTechniques[MysteriousHeavenTechnique.unique]
            .multiplier +
        state.martialSoul.multiplier);

    energy = double.parse(energy.toStringAsFixed(energy < 1 ? 2 : 0));

    if (!state.isCultivate) {
      energy = 0.0;
    }

    if (state.energyShare[state.soulPower.id] > 0 &&
        !state.soulPower.breakThrough) {
      soulPower.energy += energy * state.energyShare[state.soulPower.id];
    }

    if (state.energyShare[state.spiritualPower.id] >
        0 /*  && !state.soulPower.breakThrough */) {
      spiritualPower.energy +=
          energy * state.energyShare[state.spiritualPower.id];
    }

    if (state.energyShare[state.technique.id] > 0) {
      technique.energy += energy * state.energyShare[state.technique.id];
    }

    if (state.energyShare[state.soulRing.id] > 0) {
      soulRing.energyTemp(energy * state.energyShare[state.soulRing.id]);
    }

    emit(SoullandInitial(
      martialSoul: state.martialSoul,
      soulPower: soulPower,
      spiritualPower: spiritualPower,
      soulRing: soulRing,
      technique: technique,
      isCultivate: state.isCultivate,
      energyShare: state.energyShare,
    ));
  }

  void updateMartialSoul(int index) {
    MartialSoul martialSoul = MartialSoul.cloneWith(state.martialSoul);

    Random random = Random();

    int n = MartialSoul.spirits[index].list.length;
    int count = random.nextInt(n);

    martialSoul.name = MartialSoul.spirits[index].list[count];

    emit(SoullandInitial(
      martialSoul: martialSoul,
      soulPower: state.soulPower,
      spiritualPower: state.spiritualPower,
      soulRing: state.soulRing,
      technique: state.technique,
      isCultivate: state.isCultivate,
      energyShare: state.energyShare,
    ));
  }

  void updateMartialSoulQuality() {
    MartialSoul martialSoul = MartialSoul.cloneWith(state.martialSoul);

    if (martialSoul.level == 0) {
      if (state.soulPower.energy <= 30) {
        return;
      }

      martialSoul.level++;
      martialSoul.multiplier = MartialSoul.multipliers[martialSoul.level];
    }

    if (martialSoul.level == 1) {
      int spiritSouls =
          state.soulRing.spiritSouls.where((item) => item.year > 100).length;

      int techniques = state.technique.tangSectTechniques
          .where((item) => item.level > 100 && item.isLevel)
          .length;

      if (spiritSouls + techniques < 6) {
        return;
      }

      martialSoul.level++;
      martialSoul.multiplier = MartialSoul.multipliers[martialSoul.level];
    }

    if (martialSoul.level == 2) {
      if (state.soulPower.energy <= 40) {
        return;
      }

      if (state.spiritualPower.spiritual < 500) {
        return;
      }

      int techniques = state.technique.tangSectTechniques
          .where((item) => item.level > 500 && item.isLevel)
          .length;

      if (techniques < 3) {
        return;
      }

      martialSoul.level++;
      martialSoul.multiplier = MartialSoul.multipliers[martialSoul.level];
    }

    if (martialSoul.level == 3) {
      if (state.soulPower.energy <= 50) {
        return;
      }

      int spiritSouls =
          state.soulRing.spiritSouls.where((item) => item.year > 1000).length;

      if (spiritSouls < 4) {
        return;
      }

      martialSoul.level++;
      martialSoul.multiplier = MartialSoul.multipliers[martialSoul.level];
    }

    if (martialSoul.level == 4) {
      if (state.soulPower.energy <= 60) {
        return;
      }

      if (state.spiritualPower.spiritual < 5000) {
        return;
      }

      int spiritSouls =
          state.soulRing.spiritSouls.where((item) => item.year > 10000).length;

      if (spiritSouls < 4) {
        return;
      }

      martialSoul.level++;
      martialSoul.multiplier = MartialSoul.multipliers[martialSoul.level];
    }

    if (martialSoul.level == 5) {
      if (state.soulPower.energy <= 70) {
        return;
      }

      int spiritSouls =
          state.soulRing.spiritSouls.where((item) => item.year > 10000).length;

      int techniques = state.technique.tangSectTechniques
          .where((item) => item.level > 5000 && item.isLevel)
          .length;

      if (spiritSouls + techniques < 10) {
        return;
      }

      martialSoul.level++;
      martialSoul.multiplier = MartialSoul.multipliers[martialSoul.level];
    }

    if (martialSoul.level == 6) {
      if (state.soulPower.energy <= 80) {
        return;
      }

      if (state.spiritualPower.spiritual < 20000) {
        return;
      }

      int spiritSouls =
          state.soulRing.spiritSouls.where((item) => item.year > 100000).length;

      if (spiritSouls <= 0) {
        return;
      }

      martialSoul.level++;
      martialSoul.multiplier = MartialSoul.multipliers[martialSoul.level];
    }

    if (martialSoul.level == 7) {
      if (state.soulPower.energy < 95) {
        return;
      }

      int spiritSouls =
          state.soulRing.spiritSouls.where((item) => item.year > 100000).length;

      int techniques = state.technique.tangSectTechniques
          .where((item) => item.level > 10000 && item.isLevel)
          .length;

      if (spiritSouls + techniques < 9) {
        return;
      }

      martialSoul.level++;
      martialSoul.multiplier = MartialSoul.multipliers[martialSoul.level];
    }

    if (martialSoul.level == 8) {
      if (state.soulPower.energy < 99) {
        return;
      }

      if (state.spiritualPower.spiritual < 50000) {
        return;
      }

      int spiritSouls =
          state.soulRing.spiritSouls.where((item) => item.year > 100000).length;

      int techniques = state.technique.tangSectTechniques
          .where((item) => item.level > 100000 && item.isLevel)
          .length;

      if (spiritSouls + techniques < 12) {
        return;
      }

      martialSoul.level++;
      martialSoul.multiplier = MartialSoul.multipliers[martialSoul.level];
    }

    emit(SoullandInitial(
      martialSoul: martialSoul,
      soulPower: state.soulPower,
      spiritualPower: state.spiritualPower,
      soulRing: state.soulRing,
      technique: state.technique,
      isCultivate: state.isCultivate,
      energyShare: state.energyShare,
    ));
  }

  void updateEnergyShare(int index, double rate) {
    List<double> list = List.from(state.energyShare);
    list[index] = rate;

    emit(SoullandInitial(
      martialSoul: state.martialSoul,
      soulPower: state.soulPower,
      spiritualPower: state.spiritualPower,
      soulRing: state.soulRing,
      technique: state.technique,
      isCultivate: state.isCultivate,
      energyShare: list,
    ));
  }

  void updateSoulPower() {
    SoulPower soulPower = SoulPower.cloneWith(state.soulPower);

    soulPower.rank++;
    soulPower.energy = 0.0;
    soulPower.limitBreak = false;
    soulPower.breakThrough = false;

    emit(SoullandInitial(
      martialSoul: state.martialSoul,
      soulPower: soulPower,
      spiritualPower: state.spiritualPower,
      soulRing: state.soulRing,
      technique: state.technique,
      isCultivate: state.isCultivate,
      energyShare: state.energyShare,
    ));
  }

  void updateSoulPowerBreak() {
    SoulPower soulPower = SoulPower.cloneWith(state.soulPower);

    soulPower.breakThrough = !state.soulPower.breakThrough;
    soulPower.limitBreak = true;

    emit(SoullandInitial(
      martialSoul: state.martialSoul,
      soulPower: soulPower,
      spiritualPower: state.spiritualPower,
      soulRing: state.soulRing,
      technique: state.technique,
      isCultivate: state.isCultivate,
      energyShare: state.energyShare,
    ));
  }

  void updateSpiritual() {
    SpiritualPower spiritualPower =
        SpiritualPower.cloneWith(state.spiritualPower);

    Technique technique = Technique.cloneWith(state.technique);

    spiritualPower.spiritual++;
    spiritualPower.energy = state.spiritualPower.energy -
        SpiritualPower.expCap[state.spiritualPower.level];

    int spiritual = state.spiritualPower.spiritual;
    double multiplier = state
        .technique.tangSectTechniques[PurpleDemonEyes.unique].multiplierOrigin;

    technique.tangSectTechniques[PurpleDemonEyes.unique].multiplier =
        pow(spiritual, 1 / multiplier).toDouble() * spiritual;

    emit(SoullandInitial(
      martialSoul: state.martialSoul,
      soulPower: state.soulPower,
      spiritualPower: spiritualPower,
      soulRing: state.soulRing,
      technique: technique,
      isCultivate: state.isCultivate,
      energyShare: state.energyShare,
    ));
  }

  void updateSoulRing(int count) {
    SoulRing soulRing = SoulRing.cloneWith(state.soulRing);

    int exp = state.soulRing.spiritSouls[count].expInfo();
    double remain = state.soulRing.spiritSouls[count].energy - exp;

    soulRing.spiritSouls[count].year++;
    soulRing.spiritSouls[count].energy = remain;

    int year = state.soulRing.spiritSouls[count].year;
    double multiplier =
        SpiritSoul.multipliers[state.soulRing.spiritSouls[count].level];

    soulRing.multiplier -= state.soulRing.spiritSouls[count].multiplier;

    double pw1 = pow(multiplier, 2).toDouble();
    double pw2 = pow(year, 1 / multiplier).toDouble();
    soulRing.spiritSouls[count].multiplier = pw1 + pw2 * year;

    soulRing.multiplier += state.soulRing.spiritSouls[count].multiplier;

    emit(SoullandInitial(
      martialSoul: state.martialSoul,
      soulPower: state.soulPower,
      spiritualPower: state.spiritualPower,
      soulRing: soulRing,
      technique: state.technique,
      isCultivate: state.isCultivate,
      energyShare: state.energyShare,
    ));
  }

  void updateSoulRingBreak(int count) {
    SoulRing soulRing = SoulRing.cloneWith(state.soulRing);

    if (state.soulRing.spiritSouls[count].level >= SpiritSoul.nameCap.length) {
      return;
    }

    soulRing.multiplier -= state.soulRing.spiritSouls[count].multiplier;
    soulRing.spiritSouls[count].level++;

    int year = state.soulRing.spiritSouls[count].year;
    double multiplier =
        SpiritSoul.multipliers[state.soulRing.spiritSouls[count].level];

    soulRing.spiritSouls[count].multiplier = multiplier * log10(year);
    soulRing.multiplier += state.soulRing.spiritSouls[count].multiplier;

    emit(SoullandInitial(
      martialSoul: state.martialSoul,
      soulPower: state.soulPower,
      spiritualPower: state.spiritualPower,
      soulRing: soulRing,
      technique: state.technique,
      isCultivate: state.isCultivate,
      energyShare: state.energyShare,
    ));
  }

  void updateSpiritSoul() {
    SoulRing soulRing = SoulRing.cloneWith(state.soulRing);

    soulRing.soulTemp();

    emit(SoullandInitial(
      martialSoul: state.martialSoul,
      soulPower: state.soulPower,
      spiritualPower: state.spiritualPower,
      soulRing: soulRing,
      technique: state.technique,
      isCultivate: state.isCultivate,
      energyShare: state.energyShare,
    ));
  }

  void updateSpiritSoulYear(int count, bool value) {
    SoulRing soulRing = SoulRing.cloneWith(state.soulRing);

    soulRing.spiritSouls[count].isYear = value;

    emit(SoullandInitial(
      martialSoul: state.martialSoul,
      soulPower: state.soulPower,
      spiritualPower: state.spiritualPower,
      soulRing: soulRing,
      technique: state.technique,
      isCultivate: state.isCultivate,
      energyShare: state.energyShare,
    ));
  }

  void updateIsCultivate() {
    emit(SoullandInitial(
      martialSoul: state.martialSoul,
      soulPower: state.soulPower,
      spiritualPower: state.spiritualPower,
      soulRing: state.soulRing,
      technique: state.technique,
      isCultivate: !state.isCultivate,
      energyShare: state.energyShare,
    ));
  }
}
