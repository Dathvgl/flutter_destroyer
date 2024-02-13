import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/blocs/auth/auth_bloc.dart';
import 'package:flutter_destroyer/enum.dart';
import 'package:go_router/go_router.dart';
import 'package:sign_in_button/sign_in_button.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final authState = state.status == AuthStatus.authenticated;
        return Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SignInButton(
                  Buttons.google,
                  text: "Đăng nhập bằng Google",
                  onPressed: authState
                      ? () => {}
                      : () => context
                          .read<AuthBloc>()
                          .add(AuthGoogle(callback: () => context.pop())),
                ),
                TextButton(
                  onPressed: state.status != AuthStatus.authenticated
                      ? null
                      : () => context.read<AuthBloc>().add(AuthOut()),
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
