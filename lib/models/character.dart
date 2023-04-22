import 'dart:convert';
import 'dart:developer';

import 'package:gibt_1/models/models.dart';

class Character {
  Character({
    required this.id,
    required this.name,
    required this.title,
    required this.occupation,
    required this.association,
    required this.rarity,
    required this.weaponType,
    required this.element,
    required this.dayOfBirth,
    required this.monthOfBirth,
    required this.vision,
    required this.constellation,
    required this.description,
    required this.ascensionMaterials,
    required this.skillAscensionMaterials,
    required this.stats,
    required this.skills,
    this.visionDiscovered,
    this.constellationDiscovered,
  });

  String id;
  String name;
  String title;
  String occupation;
  _Association association;
  int rarity;
  WeaponType weaponType;
  _Element element;
  String dayOfBirth;
  String monthOfBirth;
  _Vision vision;
  String constellation;
  String description;
  List<DescriptionAscensionMaterial> ascensionMaterials;
  List<DescriptionAscensionMaterial> skillAscensionMaterials;
  List<CharacterStat> stats;
  List<CharacterSkill> skills;
  _Vision? visionDiscovered;
  String? constellationDiscovered;

  factory Character.fromRawJson(String str) =>
      Character.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json["id"],
        name: json["name"],
        title: json["title"],
        occupation: json["occupation"],
        association: associationValues.map[json["association"]]!,
        rarity: json["rarity"],
        weaponType: weaponTypeValues.map[json["weapon_type"]]!,
        element: elementValues.map[json["element"]]!,
        dayOfBirth: json["day_of_birth"],
        monthOfBirth: json["month_of_birth"],
        vision: visionValues.map[json["vision"]]!,
        constellation: json["constellation"],
        description: json["description"],
        ascensionMaterials: List<DescriptionAscensionMaterial>.from(
            json["ascension_materials"]
                .map((x) => DescriptionAscensionMaterial.fromJson(x))),
        skillAscensionMaterials: List<DescriptionAscensionMaterial>.from(
            json["skill_ascension_materials"]
                .map((x) => DescriptionAscensionMaterial.fromJson(x))),
        stats: List<CharacterStat>.from(
            json["stats"].map((x) => CharacterStat.fromJson(x))),
        skills: List<CharacterSkill>.from(
            json["skills"].map((x) => CharacterSkill.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "title": title,
        "occupation": occupation,
        "association": associationValues.reverse[association],
        "rarity": rarity,
        "weapon_type": weaponTypeValues.reverse[weaponType],
        "element": elementValues.reverse[element],
        "day_of_birth": dayOfBirth,
        "month_of_birth": monthOfBirth,
        "vision": visionValues.reverse[vision],
        "constellation": constellation,
        "description": description,
        "ascension_materials":
            List<dynamic>.from(ascensionMaterials.map((x) => x.toJson())),
        "skill_ascension_materials":
            List<dynamic>.from(skillAscensionMaterials.map((x) => x.toJson())),
        "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
        "skills": List<dynamic>.from(skills.map((x) => x)),
      };

  bool isUsingMaterial(MaterialItem material) { 
    return this.ascensionMaterials.any((asc_mat) => asc_mat.id == material.id);
  }
  bool isUsingSkillMaterial(MaterialItem material) { 
    return this.skillAscensionMaterials.any((asc_mat) => asc_mat.id == material.id);
  }
  int getSkillsMaterialQuantity (MaterialItem material, {
    int basicTalentLevel = 1, 
    int elementalTalentLevel = 1, 
    int burstTalentLevel = 1,
    int toBasicTalentLevel = 9, 
    int toElementalTalentLevel = 9, 
    int toBurstTalentLevel = 9,
  }) {
    int quantity = 0;
    for(int i = 0; i < this.skills.length; i++){
      var lvl = int.parse(this.skills[i].level);
      if(lvl > basicTalentLevel || lvl > elementalTalentLevel || lvl > burstTalentLevel){
        if(this.skills[i].materials.any((element) => element.id == material.id)){
          var skillMaterial = this.skills[i].materials.firstWhere((element) => element.id == material.id);
          if(lvl > basicTalentLevel && lvl <= toBasicTalentLevel) quantity += int.parse(skillMaterial.quantity);
          if(lvl > elementalTalentLevel && lvl <= toElementalTalentLevel) quantity += int.parse(skillMaterial.quantity);
          if(lvl > burstTalentLevel && lvl <= toBurstTalentLevel) quantity += int.parse(skillMaterial.quantity);
        }
      }
    }
    return quantity;
  }

  int getStatMaterialQuantity (MaterialItem material, {
    String level = '1', 
    String toLevel = '90', 
  }) {
    int quantity = 0;
    var lvl = accountCharacterLevels.map[level]!;
    var toLvl = accountCharacterLevels.map[toLevel]!;
    for(int i = 0; i < this.stats.length; i++){
      var statLvl = accountCharacterLevels.map[this.stats[i].level]!;
      if(lvl < statLvl && statLvl < toLvl && this.stats[i].materials.any((element) => element.id == material.id)){
        var statMaterial = this.stats[i].materials.firstWhere((element) => element.id == material.id);
        quantity += int.parse(statMaterial.quantity);
      }
    }
    return quantity;
  }
}

enum _Association { INAZUMA, MONDSTADT, LIYUE, FATUI, RANGER, SUMERU }

final associationValues = EnumValues({
  "Fatui": _Association.FATUI,
  "Inazuma": _Association.INAZUMA,
  "Liyue": _Association.LIYUE,
  "Mondstadt": _Association.MONDSTADT,
  "Ranger": _Association.RANGER,
  "Sumeru": _Association.SUMERU
});

enum _Element { UNKNOWN }

final elementValues = EnumValues({"unknown": _Element.UNKNOWN});

enum _Vision { CRYO, ANEMO, ELECTRO, HYDRO, PYRO, GEO, DENDRO }

final visionValues = EnumValues({
  "Anemo": _Vision.ANEMO,
  "Cryo": _Vision.CRYO,
  "Dendro": _Vision.DENDRO,
  "Electro": _Vision.ELECTRO,
  "Geo": _Vision.GEO,
  "Hydro": _Vision.HYDRO,
  "Pyro": _Vision.PYRO
});
