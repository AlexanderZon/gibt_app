

import 'dart:convert';

import 'package:gibt_1/models/models.dart';

class MaterialItem {
    MaterialItem({
        required this.id,
        required this.name,
        required this.rarity,
        required this.description,
        required this.materialType,
        required this.weekdays,
    });

    String id;
    String name;
    int rarity;
    String description;
    AscensionMaterialType materialType;
    List<Weekday> weekdays;

    factory MaterialItem.fromRawJson(String str) => MaterialItem.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MaterialItem.fromJson(Map<String, dynamic> json) { 
      return MaterialItem(
        id: json["id"],
        name: json["name"],
        rarity: json["rarity"],
        description: json["description"],
        materialType: materialTypeValues.map[json["material_type"]]!,
        weekdays: List<Weekday>.from(json["weekdays"].map((x) => weekdayValues.map[x]!)),
      );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "rarity": rarity,
        "description": description,
        "material_type": materialTypeValues.reverse[materialType],
        "weekdays": List<dynamic>.from(weekdays.map((x) => weekdayValues.reverse[x])),
    };
}

enum AscensionMaterialType { JEWEL, ELEMENTAL_STONE, LOCAL_MATERIAL, COMMON_ITEM, BOOK, BOSS_ITEM, REWARD_ITEM, PRIMARY_ASCENSION_MATERIAL, SECONDARY_ASCENSION_MATERIAL }

final materialTypeValues = EnumValues({
    "Book": AscensionMaterialType.BOOK,
    "BossItem": AscensionMaterialType.BOSS_ITEM,
    "CommonItem": AscensionMaterialType.COMMON_ITEM,
    "ElementalStone": AscensionMaterialType.ELEMENTAL_STONE,
    "Jewel": AscensionMaterialType.JEWEL,
    "LocalMaterial": AscensionMaterialType.LOCAL_MATERIAL,
    "PrimaryAscensionMaterial,": AscensionMaterialType.PRIMARY_ASCENSION_MATERIAL,
    "RewardItem": AscensionMaterialType.REWARD_ITEM,
    "SecondaryAscensionMaterial,": AscensionMaterialType.SECONDARY_ASCENSION_MATERIAL
});

enum Weekday { MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY }

final weekdayValues = EnumValues({
    "Monday": Weekday.MONDAY,
    "Tuesday": Weekday.TUESDAY,
    "Wednesday": Weekday.WEDNESDAY,
    "Thursday": Weekday.THURSDAY,
    "Friday": Weekday.FRIDAY,
    "Saturday": Weekday.SATURDAY,
    "Sunday": Weekday.SUNDAY,
});