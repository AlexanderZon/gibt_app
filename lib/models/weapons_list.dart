// To parse this JSON data, do
//
//     final weaponList = weaponListFromJson(jsonString);

import 'dart:convert';

import 'package:gibt_1/models/models.dart';

class WeaponsList {
  WeaponsList({
    required this.list,
  });

  List<Weapon> list;

  factory WeaponsList.fromRawJson(String str) =>
      WeaponsList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WeaponsList.fromJson(Map<String, dynamic> json) => WeaponsList(
        list: List<Weapon>.from(json["list"].map((x) => Weapon.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}