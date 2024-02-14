abstract class DauLaChung {
  void reset();
}

abstract class JsonMap {
  // JsonMap.fromMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap();
}

abstract class JsonList {
  List mapList(String str);
}
