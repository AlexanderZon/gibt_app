import 'dart:convert';

import 'package:gibt_1/models/models.dart';

class CharactersList {
    CharactersList({
        required this.list,
    });

    List<Character> list;

    factory CharactersList.fromRawJson(String str) => CharactersList.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CharactersList.fromJson(Map<String, dynamic> json) => CharactersList(
        list: List<Character>.from(json["list"].map((x) => Character.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
    };
}