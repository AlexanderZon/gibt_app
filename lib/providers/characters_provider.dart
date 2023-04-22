import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gibt_1/models/models.dart';

class CharactersProvider extends ChangeNotifier {

  List<Character> onDisplayCharacters = [];

  final StreamController<List<Character>> _suggestionStreamController = new StreamController.broadcast();
  Stream<List<Character>> get suggestionStream => _suggestionStreamController.stream;

  CharactersProvider() {
    getOnDisplayCharacters();
  }
  Future<String> readJson() async {
    final String response = 
          await rootBundle.loadString('assets/data/characters.json');
    return response;
  }

  getOnDisplayCharacters() async {
    var jsonData = await readJson();

    final charactersList = CharactersList.fromRawJson(jsonData);
    
    onDisplayCharacters = charactersList.list;
    notifyListeners();
  }
}