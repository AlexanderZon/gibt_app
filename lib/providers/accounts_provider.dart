import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gibt_1/models/models.dart';

class AccountsProvider extends ChangeNotifier {

  // ignore: avoid_init_to_null
  dynamic activeAccount = null;

  List<Account> list = [];

  final StreamController<List<Account>> _suggestionStreamController = StreamController.broadcast();
  Stream<List<Account>> get suggestionStream => _suggestionStreamController.stream;

  AccountsProvider() {
    getActiveAccount();
    all();
  }
  Future<String> readJson() async {
    final String response = 
          await rootBundle.loadString('assets/data/characters.json');
    return response;
  }

  getActiveAccount() async {
    var account = await Account.getActive();    
    activeAccount = account;
    notifyListeners();
  }

  all() async {
    list = await Account.all();  
    notifyListeners();
  }

  store(Account account) async {
    account.id = await account.save();
    list.add(account);
    notifyListeners();
  }

  update(Account account) async {
    await Account.update(account);
    final actualElement = list.firstWhere((element) => element.id == account.id);
    final position = list.indexOf(actualElement);
    list[position] = account;
    notifyListeners();
  }

  delete(Account account) async {
    if(account.id != null){
      await Account.delete(account.id!);
      list.removeWhere((element) => element.id == account.id);
      notifyListeners();
    }
  }

  select(Account account) async {
    var activeAccount = await Account.getActive(); 
    activeAccount.isActive = false;
    update(activeAccount);
    account.isActive = true;
    update(account);
    getActiveAccount();
    notifyListeners();
  }
}