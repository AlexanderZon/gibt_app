import 'dart:convert';

import 'package:gibt_1/models/models.dart';
import 'package:gibt_1/providers/db_provider.dart';

class AccountCharacter {
  AccountCharacter({
    this.id,
    required this.accountId,
    required this.characterId,
    required this.weaponId,
    required this.level,
    required this.constellations,
    required this.basicTalentLevel,
    required this.elementalTalentLevel,
    required this.burstTalentLevel,
    required this.weapLevel,
    required this.weapRank,
    required this.isBuilding,
  });

  int? id;
  int accountId;
  String characterId;
  String weaponId;
  String level;
  int constellations;
  int basicTalentLevel;
  int elementalTalentLevel;
  int burstTalentLevel;
  String weapLevel;
  int weapRank;
  bool isBuilding;
  Character? character;
  Weapon? weapon;

  factory AccountCharacter.fromRawJson(String str) =>
      AccountCharacter.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AccountCharacter.fromJson(Map<String, dynamic> json) =>
      AccountCharacter(
        id: json["id"],
        accountId: json["account_id"],
        characterId: json["character_id"],
        weaponId: json["weapon_id"],
        level: json["level"],
        constellations: json["constellations"],
        basicTalentLevel: json["basic_talent_level"],
        elementalTalentLevel: json["elemental_talent_level"],
        burstTalentLevel: json["burst_talent_level"],
        weapLevel: json["weap_level"],
        weapRank: json["weap_rank"],
        isBuilding: json["is_building"] is bool ? json["is_building"] : json["is_building"] == 1 ? true : false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "account_id": accountId,
        "character_id": characterId,
        "weapon_id": weaponId,
        "level": level,
        "constellations": constellations,
        "basic_talent_level": basicTalentLevel,
        "elemental_talent_level": elementalTalentLevel,
        "burst_talent_level": burstTalentLevel,
        "weap_level": weapLevel,
        "weap_rank": weapRank,
        "is_building": isBuilding,
      };

  static Future<dynamic> find(int id) async {
    final db = await DBProvider.db.database;
    final res = await db.query('account_characters', where: 'id = ?', whereArgs: [id]);
    final response = res.isNotEmpty ? AccountCharacter.fromJson(res.first) : null;

    return response;
  }

  static Future<List<AccountCharacter>> all() async {
    final db = await DBProvider.db.database;
    final res = await db.query('account_characters');
    final response = res.isNotEmpty
        ? res.map((e) => AccountCharacter.fromJson(e)).toList()
        : <AccountCharacter>[];

    return response;
  }

  static Future<int> store(AccountCharacter accountCharacter) async {
    final db = await DBProvider.db.database;
    final res = await db.insert('account_characters', accountCharacter.toJson());
    return res;
  }

  Future<int> save() async {
    if(id == null){
      return AccountCharacter.store(this);
    } else {
      return AccountCharacter.update(this);
    }
  }

  static Future<int> update(AccountCharacter accountCharacter) async {
    final db = await DBProvider.db.database;
    final res = await db.update('account_characters', accountCharacter.toJson(),
        where: 'id = ?', whereArgs: [accountCharacter.id]);
    return res;
  }

  static Future<int> delete(int id) async {
    final db = await DBProvider.db.database;
    final res = await db.delete('account_characters', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  static Future<int> truncate() async {
    final db = await DBProvider.db.database;
    final res = await db.delete('account_characters');
    return res;
  }

  // Indexes
  static Future<List<AccountCharacter>> where(String field, dynamic id) async {
    final db = await DBProvider.db.database;
    final res = await db.query('account_characters', where: '? = ?', whereArgs: [field, id]);
    final response = res.isNotEmpty
        ? res.map((e) => AccountCharacter.fromJson(e)).toList()
        : <AccountCharacter>[];
    return response;
  }

  static Future<List<AccountCharacter>> whereAccountId(int id) async {
    final db = await DBProvider.db.database;
    final res = await db.query('account_characters', where: 'account_id = ?', whereArgs: [id]);
    final response = res.isNotEmpty
        ? res.map((e) => AccountCharacter.fromJson(e)).toList()
        : <AccountCharacter>[];
    return response;
  }

  static Future<List<AccountCharacter>> whereCharacterId(String id) async {
    return AccountCharacter.where('character_id', id);
  }
}

enum AccountCharacterLevel { l1, l20, l20p, l40, l40p, l50, l50p, l60, l60p, l70, l70p, l80, l80p, l90 }

final accountCharacterLevels = EnumValues({
    "1": AccountCharacterLevel.l1,
    "20": AccountCharacterLevel.l20,
    "20+": AccountCharacterLevel.l20p,
    "40": AccountCharacterLevel.l40,
    "40+": AccountCharacterLevel.l40p,
    "50": AccountCharacterLevel.l50,
    "50+": AccountCharacterLevel.l50p,
    "60": AccountCharacterLevel.l60,
    "60+": AccountCharacterLevel.l60p,
    "70": AccountCharacterLevel.l70,
    "70+": AccountCharacterLevel.l70p,
    "80": AccountCharacterLevel.l80,
    "80+": AccountCharacterLevel.l80p,
    "90": AccountCharacterLevel.l90,
});

extension EnumComparisonOperators<T extends Enum> on T {
  bool operator <(T other) {
    return index < other.index;
  }

  bool operator <=(T other) {
    return index <= other.index;
  }

  bool operator >(T other) {
    return index > other.index;
  }

  bool operator >=(T other) {
    return index >= other.index;
  }
}