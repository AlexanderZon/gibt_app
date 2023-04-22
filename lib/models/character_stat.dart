import 'dart:convert';

import 'package:gibt_1/models/models.dart';

class CharacterStat {
  CharacterStat({
    required this.level,
    required this.hp,
    required this.atk,
    required this.def,
    required this.critRate,
    required this.critDmg,
    required this.variableStat,
    required this.variableStatValue,
    required this.materials,
  });

  String level;
  String hp;
  String atk;
  String def;
  String critRate;
  String critDmg;
  VariableStat variableStat;
  String variableStatValue;
  List<StatAscensionMaterial> materials;

  factory CharacterStat.fromRawJson(String str) =>
      CharacterStat.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CharacterStat.fromJson(Map<String, dynamic> json) => CharacterStat(
        level: json["level"],
        hp: json["hp"],
        atk: json["atk"],
        def: json["def"],
        critRate: json["crit_rate"],
        critDmg: json["crit_dmg"],
        variableStat: variableStatValues.map[json["variable_stat"]]!,
        variableStatValue: json["variable_stat_value"],
        materials: List<StatAscensionMaterial>.from(json["materials"]
            .map((x) => StatAscensionMaterial.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "level": level,
        "hp": hp,
        "atk": atk,
        "def": def,
        "crit_rate": critRate,
        "crit_dmg": critDmg,
        "variable_stat": variableStatValues.reverse[variableStat],
        "variable_stat_value": variableStatValue,
        "materials": List<dynamic>.from(materials.map((x) => x.toJson())),
      };
}