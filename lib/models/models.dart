export 'package:gibt_1/models/account_character.dart';
export 'package:gibt_1/models/account.dart';
export 'package:gibt_1/models/ascension_material.dart';
export 'package:gibt_1/models/character.dart';
export 'package:gibt_1/models/character_skill.dart';
export 'package:gibt_1/models/character_stat.dart';
export 'package:gibt_1/models/characters_list.dart';
export 'package:gibt_1/models/farming_material.dart';
export 'package:gibt_1/models/material_item.dart';
export 'package:gibt_1/models/materials_list.dart';
export 'package:gibt_1/models/variable_stat.dart';
export 'package:gibt_1/models/weapon_type.dart';
export 'package:gibt_1/models/weapon_stat.dart';
export 'package:gibt_1/models/weapon.dart';
export 'package:gibt_1/models/weapons_list.dart';

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}