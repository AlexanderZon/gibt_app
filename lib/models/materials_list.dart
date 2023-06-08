import 'dart:convert';

import 'package:gibt_1/models/models.dart';

class MaterialsList {
  MaterialsList({
    required this.list,
  });

  List<MaterialItem> list;

  factory MaterialsList.fromRawJson(String str) =>
      MaterialsList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MaterialsList.fromJson(Map<String, dynamic> json) => MaterialsList(
        list: List<MaterialItem>.from(
            json["list"].map((x) => MaterialItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}
