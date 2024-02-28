import 'package:flutter/material.dart';
import 'package:flutter_destroyer/cubits/soulLand/soul_land_cubit.dart';
import 'package:flutter_destroyer/pages/soulLand/cultivate/cultivate_power.dart';
import 'package:flutter_destroyer/pages/soulLand/cultivate/cultivate_spiritual.dart';
import 'package:provider/provider.dart';

class CultivatePage extends StatelessWidget {
  const CultivatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 30.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/honSu/meditation.png",
                width: 250.0,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Center(
                child: Text(
                  context.read<SoulLandCubit>().state.name,
                  style: const TextStyle(
                    fontSize: 40.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CultivatePower(),
                    SizedBox(
                      height: 30.0,
                    ),
                    CultivateSpiritual(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
