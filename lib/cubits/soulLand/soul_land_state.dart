part of 'soul_land_cubit.dart';

sealed class SoulLandState extends Equatable {
  final MartialSoul martialSoul;
  final SoulPower soulPower;
  final SpiritualPower spiritualPower;
  final SoulRing soulRing;
  final Technique technique;

  final String name = "fsfssfssfsfsfs";
  final bool isCultivate;

  final double energyBase = 0.01;

  final List<double> energyShare;

  const SoulLandState({
    required this.martialSoul,
    required this.soulPower,
    required this.spiritualPower,
    required this.soulRing,
    required this.technique,
    this.isCultivate = false,
    this.energyShare = const [
      0.0,
      0.0,
      0.0,
      0.0,
    ],
  });

  @override
  List<Object> get props => [
        martialSoul,
        soulPower,
        spiritualPower,
        soulRing,
        technique,
        isCultivate,
        energyShare,
      ];
}

final class SoullandInitial extends SoulLandState {
  const SoullandInitial({
    required super.martialSoul,
    required super.soulPower,
    required super.spiritualPower,
    required super.soulRing,
    required super.technique,
    super.isCultivate,
    super.energyShare,
  });
}
