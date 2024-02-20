import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/cubits/user/user_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:sign_in_button/sign_in_button.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      buildWhen: (previous, current) {
        return previous.user != current.user;
      },
      builder: (context, state) {
        final authState = state.user == null;

        return Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SignInButton(
                  Buttons.google,
                  text: "Đăng nhập bằng Google",
                  onPressed: () {
                    if (authState) {
                      context
                          .read<UserCubit>()
                          .signInGoogle(callback: () => context.pop());
                    }
                  },
                ),
                TextButton(
                  onPressed: () {
                    if (authState) {
                      context.read<UserCubit>().signOut();
                    }
                  },
                  child: const Text("Thoát"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
