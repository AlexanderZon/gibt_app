import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gibt_1/models/models.dart';

class MaterialsProvider extends ChangeNotifier {

  List<MaterialItem> onDisplayMaterials = [];

  final StreamController<List<MaterialItem>> _suggestionStreamController = new StreamController.broadcast();
  Stream<List<MaterialItem>> get suggestionStream => _suggestionStreamController.stream;

  MaterialsProvider() {
    getOnDisplayMaterials();
  }
  Future<String> readJson() async {
    final String response = 
          await rootBundle.loadString('assets/data/materials.json');
    return response;
  }

  getOnDisplayMaterials() async {
    var jsonData = await readJson();

    final charactersList = MaterialsList.fromRawJson(jsonData);
    
    onDisplayMaterials = charactersList.list;
    notifyListeners();
  }
}