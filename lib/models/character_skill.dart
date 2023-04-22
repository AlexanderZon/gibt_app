import 'dart:convert';

import 'package:gibt_1/models/ascension_material.dart';

class CharacterSkill {
  CharacterSkill({
    required this.level,
    required this.materials,
  });

  String level;
  List<StatAscensionMaterial> materials;

  factory CharacterSkill.fromRawJson(String str) =>
      CharacterSkill.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CharacterSkill.fromJson(Map<String, dynamic> json) => CharacterSkill(
        level: json["level"],
        materials: List<StatAscensionMaterial>.from(
            json["materials"].map((x) => StatAscensionMaterial.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "level": level,
        "materials": List<dynamic>.from(materials.map((x) => x.toJson())),
      };
}
