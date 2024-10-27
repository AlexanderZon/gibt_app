import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gibt_1/models/models.dart';
import 'package:gibt_1/providers/account_characters_provider.dart';

class HomeProvider extends ChangeNotifier {
  bool loading = false;

  DateTime farmingDay = DateTime.now();
  List<AccountCharacter> buildingCharacters = [];
  List<MaterialItem> materialsList = [];
  List<Character> charactersList = [];
  List<Weapon> weaponsList = [];

  List<FarmingMaterialData> farmingTodayMaterials = [];
  List<FarmingMaterialData> farmingBossMaterials = [];
  List<FarmingMaterialData> farmingElementalStones = [];
  List<FarmingMaterialData> farmingCharJewels = [];
  List<FarmingMaterialData> farmingLocalMaterials = [];
  List<FarmingMaterialData> farmingSecondaryMaterials = [];
  List<FarmingMaterialData> farmingCommonMaterials = [];

  HomeProvider() {
    loading = true;
    notifyListeners();
    getOnDisplayMaterials();
  }

  String get farmingDate {
    return '${farmingDay.year}/${farmingDay.month < 10 ? "0" : ""}${farmingDay.month}/${farmingDay.day < 10 ? "0" : ""}${farmingDay.day}';
  }

  String get farmingDateDay {
    var now = DateTime.now();
    if (now.year == farmingDay.year &&
        now.month == farmingDay.month &&
        now.day == farmingDay.day) {
      return 'Today';
    } else {
      return weekdayValues.reverse[Weekday.values[farmingDay.weekday - 1]]!;
    }
  }

  Future<String> readJson(String data) async {
    final String response =
        await rootBundle.loadString('assets/data/$data.json');
    return response;
  }

  void updatesFromAccountCharacters(
      AccountCharactersProvider accountCharactersProvider,
      HomeProvider previousState) {
    buildingCharacters = accountCharactersProvider.list
        .where((element) => element.isBuilding)
        .toList();
    charactersList = accountCharactersProvider.charactersList;
    weaponsList = accountCharactersProvider.weaponsList;
    materialsList = accountCharactersProvider.materialsList;
    getOnDisplayMaterials();
  }

  bool get canAddDay {
    var now = DateTime.now();
    return (now.difference(farmingDay).inHours / 24).round() > -3;
  }

  bool get canSubDay {
    var now = DateTime.now();
    return (now.difference(farmingDay).inHours / 24).round() < 3;
  }

  void addFarmingDay() {
    farmingDay = farmingDay.add(const Duration(days: 1));
    getFarmingTodayMaterials();
    notifyListeners();
  }

  void subFarmingDay() {
    farmingDay = farmingDay.subtract(const Duration(days: 1));
    getFarmingTodayMaterials();
    notifyListeners();
  }

  getOnDisplayMaterials() async {
    if (buildingCharacters.isEmpty ||
        charactersList.isEmpty ||
        weaponsList.isEmpty ||
        materialsList.isEmpty) {
      loading = false;
      notifyListeners();
      return null;
    }

    // Map AccountCharacters with Reltionships
    buildingCharacters = buildingCharacters.map((e) {
      var character =
          charactersList.firstWhere((element) => element.id == e.characterId);
      e.character = character;
      var weapon =
          weaponsList.firstWhere((element) => element.id == e.weaponId);
      e.weapon = weapon;
      return e;
    }).toList();

    getFarmingTodayMaterials();

    var bossMaterials = _filterMaterialsByType(AscensionMaterialType.BOSS_ITEM);
    farmingBossMaterials = _constructSkillFarmingMaterialList(bossMaterials);

    var elementalStones =
        _filterMaterialsByType(AscensionMaterialType.ELEMENTAL_STONE);
    farmingElementalStones =
        _constructStatCharacterFarmingMaterialList(elementalStones);

    var charJewels = _filterMaterialsByType(AscensionMaterialType.JEWEL);
    farmingCharJewels = _constructStatCharacterFarmingMaterialList(charJewels);

    var localMaterials =
        _filterMaterialsByType(AscensionMaterialType.LOCAL_MATERIAL);
    farmingLocalMaterials =
        _constructStatCharacterFarmingMaterialList(localMaterials);

    var secondaryAscensionMaterial = _filterMaterialsByType(
        AscensionMaterialType.SECONDARY_ASCENSION_MATERIAL);
    farmingSecondaryMaterials =
        _constructStatWeaponFarmingMaterialList(secondaryAscensionMaterial);

    var commonMaterials =
        _filterMaterialsByType(AscensionMaterialType.COMMON_ITEM);
    farmingCommonMaterials =
        _constructCommonFarmingMaterialList(commonMaterials);

    loading = false;
    notifyListeners();
  }

  void getFarmingTodayMaterials() {
    var actualWeekDay = Weekday.values[farmingDay.weekday - 1];
    var bookMaterials = _filterMaterialsByWeekDayAndType(
        AscensionMaterialType.BOOK, actualWeekDay);
    var primaryMaterials = _filterMaterialsByWeekDayAndType(
        AscensionMaterialType.PRIMARY_ASCENSION_MATERIAL, actualWeekDay);
    farmingTodayMaterials = _constructSkillFarmingMaterialList(bookMaterials);
    farmingTodayMaterials = [
      ...farmingTodayMaterials,
      ..._constructStatWeaponFarmingMaterialList(primaryMaterials)
    ];
  }

  bool _filterFarmingMaterialItemData(element) => element.quantity > 0;

  bool _filterFarmingMaterialData(element) =>
      element.quantity > 0 && element.items.length > 0;

  List<MaterialItem> _filterMaterialsByType(AscensionMaterialType type) {
    return materialsList
        .where((element) => element.materialType == type)
        .toList();
  }

  List<MaterialItem> _filterMaterialsByWeekDayAndType(
      AscensionMaterialType type, Weekday weekday) {
    return _filterMaterialsByType(type)
        .where((element) => element.weekdays.any((wd) => wd == weekday))
        .toList();
  }

  List<FarmingMaterialData> _constructSkillFarmingMaterialList(
      List<MaterialItem> materials) {
    return materials
        .map((element) {
          var charactersUsingMaterial = buildingCharacters.where((e) =>
              e.character!.isUsingMaterial(element) ||
              e.character!.isUsingSkillMaterial(element));

          if (charactersUsingMaterial.isEmpty) {
            return FarmingMaterialData(
                material: element, quantity: 0, items: []);
          } else {
            int total = 0;
            List<FarmingMaterialItemData> items = charactersUsingMaterial
                .map((e) {
                  int quantity = e.character!.getSkillsMaterialQuantity(element,
                      basicTalentLevel: e.basicTalentLevel,
                      elementalTalentLevel: e.elementalTalentLevel,
                      burstTalentLevel: e.burstTalentLevel);
                  total += quantity;
                  return FarmingMaterialItemData(
                      accountCharacter: e, quantity: quantity, type: 'tallent');
                })
                .where(_filterFarmingMaterialItemData)
                .toList();
            return FarmingMaterialData(
                material: element, quantity: total, items: items);
          }
        })
        .where(_filterFarmingMaterialData)
        .toList();
  }

  List<FarmingMaterialData> _constructStatCharacterFarmingMaterialList(
      List<MaterialItem> materials) {
    return materials
        .map(
          (element) {
            var charactersUsingMaterial = buildingCharacters
                .where((e) => e.character!.isUsingMaterial(element));
            if (charactersUsingMaterial.isEmpty) {
              return FarmingMaterialData(
                  material: element, quantity: 0, items: []);
            } else {
              int total = 0;
              List<FarmingMaterialItemData> items = charactersUsingMaterial
                  .map((e) {
                    int quantity = e.character!
                        .getStatMaterialQuantity(element, level: e.level);
                    total += quantity;
                    return FarmingMaterialItemData(
                        accountCharacter: e, quantity: quantity, type: 'char');
                  })
                  .where(_filterFarmingMaterialItemData)
                  .toList();
              return FarmingMaterialData(
                  material: element, quantity: total, items: items);
            }
          },
        )
        .where(_filterFarmingMaterialData)
        .toList();
  }

  List<FarmingMaterialData> _constructStatWeaponFarmingMaterialList(
      List<MaterialItem> materials) {
    return materials
        .map(
          (element) {
            var weaponsUsingMaterial = buildingCharacters
                .where((e) => e.weapon!.isUsingMaterial(element));
            if (weaponsUsingMaterial.isEmpty) {
              return FarmingMaterialData(
                  material: element, quantity: 0, items: []);
            } else {
              int total = 0;
              List<FarmingMaterialItemData> items = weaponsUsingMaterial
                  .map((e) {
                    int quantity = e.weapon!
                        .getStatMaterialQuantity(element, level: e.weapLevel);
                    total += quantity;
                    return FarmingMaterialItemData(
                        accountCharacter: e,
                        quantity: quantity,
                        type: 'weapon');
                  })
                  .where(_filterFarmingMaterialItemData)
                  .toList();
              return FarmingMaterialData(
                  material: element, quantity: total, items: items);
            }
          },
        )
        .where(_filterFarmingMaterialData)
        .toList();
  }

  List<FarmingMaterialData> _constructCommonFarmingMaterialList(
      List<MaterialItem> materials) {
    var skillsMaterials = _constructSkillFarmingMaterialList(materials);
    var charStatsMaterials =
        _constructStatCharacterFarmingMaterialList(materials);
    var weapStatsMaterials = _constructStatWeaponFarmingMaterialList(materials);
    List<FarmingMaterialData> list = [];
    list = _appendCommonMaterials(list, skillsMaterials);
    list = _appendCommonMaterials(list, charStatsMaterials);
    list = _appendCommonMaterials(list, weapStatsMaterials);

    return list;
  }

  List<FarmingMaterialData> _appendCommonMaterials(
      List<FarmingMaterialData> list, List<FarmingMaterialData> elements) {
    for (int i = 0; i < elements.length; i++) {
      if (list
          .any((element) => element.material.id == elements[i].material.id)) {
        var fcm = list.firstWhere(
            (element) => element.material.id == elements[i].material.id);
        var index = list.indexOf(fcm);
        list[index].items = [...list[index].items, ...elements[i].items];
        list[index].quantity = list[index].quantity + elements[i].quantity;
      } else {
        list.add(elements[i]);
      }
    }
    return list;
  }
}
