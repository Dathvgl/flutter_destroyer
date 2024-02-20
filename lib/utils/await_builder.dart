import 'package:flutter/material.dart';

Widget awaitFuture<T>({
  Future<T>? future,
  Widget Function(BuildContext context, T data)? done,
  Widget? none,
  Widget? wait,
}) {
  return FutureBuilder(
    future: future,
    builder: (context, snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
        case ConnectionState.waiting:
          if (wait != null) return wait;
          return const Center(
            child: CircularProgressIndicator(),
          );
        case ConnectionState.done:
        case ConnectionState.active:
        default:
          if (snapshot.hasData) {
            final data = snapshot.data as T;

            if (data == null || done == null) {
              return const SizedBox();
            }

            return done(context, data);
          } else {
            return none ?? const SizedBox();
          }
      }
    },
  );
}
