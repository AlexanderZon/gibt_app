import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gibt_1/models/models.dart';

class WeaponsProvider extends ChangeNotifier {
  List<Weapon> onDisplayWeapons = [];

  final StreamController<List<Weapon>> _suggestionStreamController =
      StreamController.broadcast();
  Stream<List<Weapon>> get suggestionStream =>
      _suggestionStreamController.stream;

  WeaponsProvider() {
    getOnDisplayWeapons();
  }
  Future<String> readJson() async {
    final String response =
        await rootBundle.loadString('assets/data/weapons.json');
    return response;
  }

  getOnDisplayWeapons() async {
    var jsonData = await readJson();

    final charactersList = WeaponsList.fromRawJson(jsonData);

    onDisplayWeapons = charactersList.list;
    notifyListeners();
  }
}
