import 'package:flutter/material.dart';
import 'package:flutter_destroyer/config.dart';
import 'package:go_router/go_router.dart';

class DrawerRoot extends StatelessWidget {
  const DrawerRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: config.length,
            itemBuilder: (context, index) {
              final item = config[index];
              return ListTile(
                title: Text(item.name),
                onTap: () {
                  context.go(item.path);
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
