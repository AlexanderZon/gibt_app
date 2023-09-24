import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gibt_1/models/models.dart';

class CharactersProvider extends ChangeNotifier {
  List<Character> onDisplayCharacters = [];

  final StreamController<List<Character>> _suggestionStreamController =
      StreamController.broadcast();
  Stream<List<Character>> get suggestionStream =>
      _suggestionStreamController.stream;

  CharactersProvider() {
    getOnDisplayCharacters();
  }

  updatesFromDataProvider(
      List<Character> characters, CharactersProvider previousState) {
    onDisplayCharacters = characters;
    notifyListeners();
  }

  getOnDisplayCharacters() async {
    if (onDisplayCharacters.isEmpty) {
      return null;
    }
    notifyListeners();
  }
}
