import 'dart:async';

import 'package:flutter/material.dart';
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

  updatesFromDataProvider(List<Weapon> weapons, WeaponsProvider previousState) {
    onDisplayWeapons = weapons;
    notifyListeners();
  }

  getOnDisplayWeapons() async {
    if (onDisplayWeapons.isEmpty) {
      return null;
    }
    notifyListeners();
  }
}
