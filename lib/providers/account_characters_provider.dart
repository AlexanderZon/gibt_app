import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gibt_1/models/models.dart';

class AccountCharactersProvider extends ChangeNotifier {

  List<AccountCharacter> list = [];

  final StreamController<List<AccountCharacter>> _suggestionStreamController = new StreamController.broadcast();
  Stream<List<AccountCharacter>> get suggestionStream => _suggestionStreamController.stream;

  AccountCharactersProvider() {
    all();
  }

  all() async {
    log("Reloading all characters");
    // await AccountCharacter.truncate();
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
    final actualElement = list.firstWhere((element) => element.id == accountCharacter.id);
    final position = list.indexOf(actualElement);
    list[position] = accountCharacter;
    notifyListeners();
  }

  delete(AccountCharacter accountCharacter) async {
    if(accountCharacter.id != null){
      await AccountCharacter.delete(accountCharacter.id!);
      list.removeWhere((element) => element.id == accountCharacter.id);
      notifyListeners();
    }
  }
}