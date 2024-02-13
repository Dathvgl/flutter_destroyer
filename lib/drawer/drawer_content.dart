import 'package:flutter/material.dart';
import 'package:flutter_destroyer/models/route.dart';
import 'package:go_router/go_router.dart';

class DrawerRootContent extends StatelessWidget {
  const DrawerRootContent({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = "/${ModalRoute.of(context)?.settings.name}";

    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          height: 0,
          thickness: 1,
        ),
        itemCount: routes.length,
        itemBuilder: (context, index) {
          final item = routes[index];
          return InkWell(
            onTap: () {
              String path = currentRoute;

              if (path == "//") {
                path = "/";
              }

              if (path == item.path) return;

              switch (item.navigation) {
                case NavigateStatus.push:
                  context.push(item.path);
                  break;
                case NavigateStatus.pushReplacement:
                  context.pushReplacement(item.path);
                  break;
                case NavigateStatus.go:
                default:
                  context.go(item.path);
                  break;
              }

              Navigator.of(context).pop();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Row(
                children: [
                  Icon(
                    item.icon,
                    size: 32,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
