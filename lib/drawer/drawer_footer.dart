import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/cubits/theme/theme_cubit.dart';

class DrawerRootFooter extends StatelessWidget {
  const DrawerRootFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                state.theme ? "Dark Mode" : "Light Mode",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(width: 20),
              Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: state.theme,
                  onChanged: (value) async {
                    await context.read<ThemeCubit>().listen(value);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
