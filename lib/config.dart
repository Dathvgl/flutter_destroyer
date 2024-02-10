class ConfigDart {
  final String path;
  final String name;

  ConfigDart({
    required this.path,
    required this.name,
  });
}

final config = [
  ConfigDart(
    path: "/",
    name: "Home Screen",
  ),
  ConfigDart(
    path: "/calculator",
    name: "Calculator Screen",
  ),
];
