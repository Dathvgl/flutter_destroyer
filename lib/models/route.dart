import 'package:flutter/material.dart';

enum NavigateStatus {
  go,
  push,
  pushReplacement,
}

class RouteModel {
  final NavigateStatus navigation;
  final String name;
  final String path;
  final IconData icon;

  RouteModel({
    required this.navigation,
    required this.name,
    required this.path,
    required this.icon,
  });
}

final routes = [
    RouteModel(
      navigation: NavigateStatus.go,
      name: "Home",
      path: "/",
      icon: Icons.home,
    ),
    RouteModel(
      navigation: NavigateStatus.push,
      name: "Settings",
      path: "/setting",
      icon: Icons.settings,
    ),
    RouteModel(
      navigation: NavigateStatus.push,
      name: "Sign in",
      path: "/auth",
      icon: Icons.supervised_user_circle,
    ),
    RouteModel(
      navigation: NavigateStatus.go,
      name: "Calculator",
      path: "/calculator",
      icon: Icons.calculate,
    ),
    RouteModel(
      navigation: NavigateStatus.go,
      name: "Manga",
      path: "/manga",
      icon: Icons.menu_book,
    ),
  ];
