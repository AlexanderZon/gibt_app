import 'dart:convert';

class DescriptionAscensionMaterial {
  DescriptionAscensionMaterial({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory DescriptionAscensionMaterial.fromRawJson(String str) =>
      DescriptionAscensionMaterial.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DescriptionAscensionMaterial.fromJson(Map<String, dynamic> json) =>
      DescriptionAscensionMaterial(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class StatAscensionMaterial {
  StatAscensionMaterial({
    required this.id,
    required this.name,
    required this.quantity,
  });

  String id;
  String name;
  int quantity;

  factory StatAscensionMaterial.fromRawJson(String str) =>
      StatAscensionMaterial.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StatAscensionMaterial.fromJson(Map<String, dynamic> json) =>
      StatAscensionMaterial(
        id: json["id"],
        name: json["name"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "quantity": quantity,
      };
}
