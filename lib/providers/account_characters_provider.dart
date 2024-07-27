import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gibt_1/models/models.dart';
import 'package:gibt_1/providers/data_provider.dart';

class AccountCharactersProvider extends ChangeNotifier {
  List<AccountCharacter> list = [];
  List<Character> charactersList = [];
  List<Weapon> weaponsList = [];
  List<MaterialItem> materialsList = [];

  final StreamController<List<AccountCharacter>> _suggestionStreamController =
      StreamController.broadcast();
  Stream<List<AccountCharacter>> get suggestionStream =>
      _suggestionStreamController.stream;

  AccountCharactersProvider() {
    all();
  }

  all() async {
    var account = await Account.getActive();
    list = await account.accountCharacters;
    notifyListeners();
  }

  store(AccountCharacter accountCharacter) async {
    accountCharacter.id = await accountCharacter.save();
    list.add(accountCharacter);
    notifyListeners();
  }

  update(AccountCharacter accountCharacter) async {
    await AccountCharacter.update(accountCharacter);
    final actualElement =
        list.firstWhere((element) => element.id == accountCharacter.id);
    final position = list.indexOf(actualElement);
    list[position] = accountCharacter;
    notifyListeners();
  }

  delete(AccountCharacter accountCharacter) async {
    if (accountCharacter.id != null) {
      await AccountCharacter.delete(accountCharacter.id!);
      list.removeWhere((element) => element.id == accountCharacter.id);
      notifyListeners();
    }
  }

  void updatesFromDataProvider(
    DataProvider data,
    AccountCharactersProvider previousState,
  ) {
    charactersList = data.characters.toList();
    weaponsList = data.weapons.toList();
    materialsList = data.materials.toList();
    notifyListeners();
  }
}
