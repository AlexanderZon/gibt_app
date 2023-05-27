import 'package:flutter/material.dart';
import 'package:gibt_1/models/models.dart';
import 'package:gibt_1/providers/account_characters_provider.dart';
import 'package:gibt_1/providers/characters_provider.dart';
import 'package:gibt_1/providers/weapons_provider.dart';
import 'package:gibt_1/widgets/widgets.dart';
import 'package:provider/provider.dart';

class WeaponsScreen extends StatelessWidget {
   
  const WeaponsScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    final columns = (size.width / 170).ceil();
    final double cardMaxSize = size.width/columns-20;

    final weaponsProvider = Provider.of<WeaponsProvider>(context, listen: true); 
    final charactersProvider = Provider.of<CharactersProvider>(context, listen: true); 
    final accountCharactersProvider = Provider.of<AccountCharactersProvider>(context, listen: true); 

    final accountCharacters = accountCharactersProvider.list;
    
    final List<AccountWeaponData> list = [
      if(weaponsProvider.onDisplayWeapons.isNotEmpty && charactersProvider.onDisplayCharacters.isNotEmpty)
      ...accountCharacters.map((e) {
        List<Weapon> filteredWeapons = weaponsProvider.onDisplayWeapons.where((element) => element.id == e.weaponId).toList();
        List<Character> filteredCharacters = charactersProvider.onDisplayCharacters.where((element) => element.id == e.characterId).toList();
        
        final character = filteredCharacters.first;
        final weapon = filteredWeapons.first;
        return AccountWeaponData(
          weapon: weapon, 
          character: character,
          level: e.weapLevel,
          basicTalentLevel: e.basicTalentLevel.toString(),
          elementalTalentLevel: e.elementalTalentLevel.toString(),
          burstTalentLevel: e.burstTalentLevel.toString(),
          constellations: e.constellations.toString(),
          isBuilding: e.isBuilding, 
          isPulled: true
        );
      },)
    ];
    list.sort((a, b) {
      if(a.weapon.rarity > b.weapon.rarity) {
        return -1;
      } else if(a.weapon.rarity < b.weapon.rarity) {
        return 1;
      } else {
        if(accountCharacterLevels.map[a.level]! > accountCharacterLevels.map[b.level]!) {
          return -1;
        } else if(accountCharacterLevels.map[a.level]! < accountCharacterLevels.map[b.level]!) {
          return 1;
        } else {
          return 0;
        }
      }
    });

    const double cardAspectRatio = 0.9;
    
    return Scaffold(
      appBar: AppBar(),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: columns,
        childAspectRatio: cardAspectRatio,
        children: list.map((e) => GestureDetector (
          onTap: () => Navigator.pushNamed(context, 'character_form', arguments: e.character),
          child: WeaponCard(
            data: e,
            maxWidth: cardMaxSize,
            aspectRatio: cardAspectRatio,
          ),
        )).toList(),
      )
    );
  }
}