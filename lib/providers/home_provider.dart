import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gibt_1/models/models.dart';
import 'package:gibt_1/providers/account_characters_provider.dart';
import 'package:provider/provider.dart';

class HomeProvider extends ChangeNotifier {

  bool loading = false;

  List<AccountCharacter> buildingCharacters = [];
  List<MaterialItem> materialsList = [];
  List<Character> charactersList = [];
  List<Weapon> weaponsList = [];

  List<FarmingMaterialData> farmingBossMaterials = [];
  List<FarmingMaterialData> farmingElementalStones = [];
  List<FarmingMaterialData> farmingCharJewels = [];
  List<FarmingMaterialData> farmingLocalMaterials = [];

  HomeProvider() {
    loading = true;
    log('HomeProvider');
    notifyListeners();
    getOnDisplayMaterials();
  }

  Future<String> readJson(String data) async {
    final String response = 
          await rootBundle.loadString('assets/data/${data}.json');
    return response;
  }

  void updates(List<AccountCharacter> accountCharacters, HomeProvider previousState){
    this.buildingCharacters = accountCharacters.where((element) => element.isBuilding).toList();
    getOnDisplayMaterials();
  }

  getOnDisplayMaterials() async {
    var materialsJsonData = await readJson('materials');
    materialsList = MaterialsList.fromRawJson(materialsJsonData).list;

    var charactersJsonData = await readJson('characters');
    charactersList = CharactersList.fromRawJson(charactersJsonData).list;

    var weaponsJsonData = await readJson('weapons');
    weaponsList = WeaponsList.fromRawJson(weaponsJsonData).list;

    // Map AccountCharacters with Reltionships
    buildingCharacters = buildingCharacters.map((e) {
      var character = charactersList.firstWhere((element) => element.id == e.characterId);
      e.character = character;
      var weapon = weaponsList.firstWhere((element) => element.id == e.weaponId);
      e.weapon = weapon;
      return e;
    }).toList();

    var bossMaterials = _filterMaterialsByType(AscensionMaterialType.BOSS_ITEM);
    farmingBossMaterials = _constructSkillFarminMaterialList(bossMaterials);

    var elementalStones = _filterMaterialsByType(AscensionMaterialType.ELEMENTAL_STONE);
    farmingElementalStones = _constructStatFarmingMaterialList(elementalStones);

    var charJewels = _filterMaterialsByType(AscensionMaterialType.JEWEL);
    farmingCharJewels = _constructStatFarmingMaterialList(charJewels);

    var localMaterials = _filterMaterialsByType(AscensionMaterialType.LOCAL_MATERIAL);
    farmingLocalMaterials = _constructStatFarmingMaterialList(localMaterials);

    loading = false;
    notifyListeners();
  }

  bool _filterFarmingMaterialData(element) => element.quantity > 0 && element.items.length > 0;

  List<MaterialItem> _filterMaterialsByType(AscensionMaterialType type) {
    return materialsList.where((element) {
        if(element.materialType == type) return true;
        return false;
    },).toList();
  }

  List<FarmingMaterialData> _constructSkillFarminMaterialList(List<MaterialItem> material){
    return material.map((element) {
      var charactersUsingMaterial = buildingCharacters.where((e) => e.character!.isUsingSkillMaterial(element));
      if(charactersUsingMaterial.isEmpty) return FarmingMaterialData(material: element, quantity: 0, items: []);
      else {
        int total = 0;
        List<FarmingMaterialItemData> items = charactersUsingMaterial.map((e){
          int quantity = e.character!.getSkillsMaterialQuantity(element, basicTalentLevel: e.basicTalentLevel, elementalTalentLevel: e.elementalTalentLevel, burstTalentLevel: e.burstTalentLevel);
          total += quantity;
          return FarmingMaterialItemData(accountCharacter: e, quantity: quantity, type: 'tallent');
        }).toList();

        return FarmingMaterialData(material: element, quantity: total, items: items);
      }
    }).where(_filterFarmingMaterialData).toList();
  }

  List<FarmingMaterialData> _constructStatFarmingMaterialList(List<MaterialItem> material){
    return material.map((element) {
      var charactersUsingMaterial = buildingCharacters.where((e) => e.character!.isUsingMaterial(element));
      if(charactersUsingMaterial.isEmpty) return FarmingMaterialData(material: element, quantity: 0, items: []);
      else {
        int total = 0;
        List<FarmingMaterialItemData> items = charactersUsingMaterial.map((e){
          int quantity = e.character!.getStatMaterialQuantity(element, level: e.level);
          total += quantity;
          return FarmingMaterialItemData(accountCharacter: e, quantity: quantity, type: 'char');
        }).toList();
        return FarmingMaterialData(material: element, quantity: total, items: items);
      }
    },).where(_filterFarmingMaterialData).toList();
  }
}