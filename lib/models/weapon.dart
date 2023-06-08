import 'dart:convert';

import 'package:gibt_1/models/models.dart';

class Weapon {
  Weapon({
    required this.id,
    required this.name,
    required this.rarity,
    required this.description,
    required this.weaponType,
    required this.ascensionMaterials,
    required this.stats,
  });

  String id;
  String name;
  int rarity;
  String description;
  WeaponType weaponType;
  List<DescriptionAscensionMaterial> ascensionMaterials;
  List<WeaponStat> stats;

  factory Weapon.fromRawJson(String str) => Weapon.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Weapon.fromJson(Map<String, dynamic> json) => Weapon(
        id: json["id"],
        name: json["name"],
        rarity: json["rarity"],
        description: json["description"],
        weaponType: weaponTypeValues.map[json["weapon_type"]]!,
        ascensionMaterials: List<DescriptionAscensionMaterial>.from(
            json["ascension_materials"]
                .map((x) => DescriptionAscensionMaterial.fromJson(x))),
        stats: List<WeaponStat>.from(
            json["stats"].map((x) => WeaponStat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "rarity": rarity,
        "description": description,
        "weapon_type": weaponTypeValues.reverse[weaponType],
        "ascension_materials":
            List<dynamic>.from(ascensionMaterials.map((x) => x.toJson())),
        "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
      };

  static String defaultWeaponId(WeaponType weaponType) {
    switch (weaponType) {
      case WeaponType.BOW:
        return 'i_n15101';
      case WeaponType.CATALYST:
        return 'i_n14101';
      case WeaponType.CLAYMORE:
        return 'i_n12101';
      case WeaponType.POLEARM:
        return 'i_n13101';
      case WeaponType.SWORD:
        return 'i_n11101';
    }
  }

  bool isUsingMaterial(MaterialItem material) {
    return ascensionMaterials.any((ascMat) => ascMat.id == material.id);
  }

  int getStatMaterialQuantity(
    MaterialItem material, {
    String level = '1',
    String toLevel = '90',
  }) {
    int quantity = 0;
    var lvl = accountCharacterLevels.map[level]!;
    var toLvl = accountCharacterLevels.map[toLevel]!;
    for (int i = 0; i < stats.length; i++) {
      var statLvl = accountCharacterLevels.map[stats[i].level]!;
      if (lvl < statLvl &&
          statLvl < toLvl &&
          stats[i].materials.any((element) => element.id == material.id)) {
        var statMaterial = stats[i]
            .materials
            .firstWhere((element) => element.id == material.id);
        quantity += statMaterial.quantity;
      }
    }
    return quantity;
  }
}
