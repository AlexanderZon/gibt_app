import 'dart:convert';

import 'package:gibt_1/models/account_character.dart';
import 'package:gibt_1/providers/db_provider.dart';

class Account {
  Account({
    this.id,
    required this.name,
    required this.server,
    required this.isActive,
  });

  int? id;
  String name;
  String server;
  bool isActive;

  factory Account.fromRawJson(String str) => Account.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["id"],
        name: json["name"],
        server: json["server"],
        isActive: json["is_active"] is bool ? json["is_active"] : json["is_active"] == 1 ? true : false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "server": server,
        "is_active": isActive,
      };

  static Future<Account> getActive() async {
    final db = await DBProvider.db.database;
    final res = await db.query('accounts', where: 'is_active = ?', whereArgs: [true]);
    final response = res.isNotEmpty ? Account.fromJson(res.first) : null;

    // Si no existe ninguna cuenta activa
    if(response == null){
      final res = await db.query('accounts');
      // Si no existe ninguna cuenta registrada
      if(res.isEmpty){
        // Crear primera cuenta
        final firstAccount = Account(name: '(Account without name)', server: 'NA', isActive: true);
        firstAccount.id = await firstAccount.save();
        return firstAccount;
      } else {
        // Setea la primera cuenta como la nueva cuenta activa
        final accountList = await Account.all();
        final newActiveAccount = accountList.first;
        newActiveAccount.isActive = true;
        await Account.update(newActiveAccount);
        return newActiveAccount;
      }
    }
    return response;
  }

  static Future<dynamic> find(int id) async {
    final db = await DBProvider.db.database;
    final res = await db.query('accounts', where: 'id = ?', whereArgs: [id]);
    final response = res.isNotEmpty ? Account.fromJson(res.first) : null;

    return response;
  }

  static Future<List<Account>> all() async {
    final db = await DBProvider.db.database;
    final res = await db.query('accounts');
    final response = res.isNotEmpty
        ? res.map((e) => Account.fromJson(e)).toList()
        : [] as List<Account>;

    return response;
  }

  static Future<int> store(Account account) async {
    final db = await DBProvider.db.database;
    final res = await db.insert('accounts', account.toJson());
    return res;
  }

  Future<int> save() async {
    return Account.store(this);
  }

  static Future<int> update(Account account) async {
    final db = await DBProvider.db.database;
    final res = await db.update('accounts', account.toJson(),
        where: 'id = ?', whereArgs: [account.id]);
    return res;
  }

  static Future<int> delete(int id) async {
    final db = await DBProvider.db.database;
    final res = await db.delete('accounts', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  static Future<int> truncate() async {
    final db = await DBProvider.db.database;
    final res = await db.delete('accounts');
    return res;
  }

  // Relationships
  Future<List<AccountCharacter>> get accountCharacters {
    return AccountCharacter.whereAccountId(id!);
  }
}
