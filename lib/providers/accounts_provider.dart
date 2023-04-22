import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gibt_1/models/models.dart';

class AccountsProvider extends ChangeNotifier {

  dynamic activeAccount = null;

  final StreamController<List<Account>> _suggestionStreamController = new StreamController.broadcast();
  Stream<List<Account>> get suggestionStream => _suggestionStreamController.stream;

  AccountsProvider() {
    getActiveAccount();
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
}