import 'dart:convert';

import 'package:gibt_1/models/models.dart';

class WeaponStat {
  WeaponStat({
    required this.level,
    required this.atk,
    this.variableStat,
    this.variableStatValue,
    required this.materials,
  });

  String level;
  double atk;
  VariableStat? variableStat;
  double? variableStatValue;
  List<StatAscensionMaterial> materials;

  factory WeaponStat.fromRawJson(String str) =>
      WeaponStat.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WeaponStat.fromJson(Map<String, dynamic> json) => WeaponStat(
        level: json["level"],
        atk: json["atk"],
        variableStat: variableStatValues.map[json["variable_stat"]],
        variableStatValue: json["variable_stat_value"],
        materials: List<StatAscensionMaterial>.from(
            json["materials"].map((x) => StatAscensionMaterial.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "level": level,
        "atk": atk,
        "variable_stat": variableStatValues.reverse[variableStat],
        "variable_stat_value": variableStatValue,
        "materials": List<dynamic>.from(materials.map((x) => x.toJson())),
      };
}
