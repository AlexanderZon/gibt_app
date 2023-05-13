import 'package:flutter/material.dart';
import 'package:gibt_1/models/models.dart';
import 'package:gibt_1/providers/account_characters_provider.dart';
import 'package:gibt_1/providers/characters_provider.dart';
import 'package:gibt_1/widgets/widgets.dart';
import 'package:provider/provider.dart';

class CharactersScreen extends StatelessWidget {
   
  const CharactersScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    final columns = (size.width / 170).ceil();
    final double cardMaxSize = size.width/columns-20;

    final charactersProvider = Provider.of<CharactersProvider>(context, listen: true); 
    final accountCharactersProvider = Provider.of<AccountCharactersProvider>(context, listen: true); 

    final accountCharacters = accountCharactersProvider.list;
    
    final List<AccountCharacterData> list = [
      ...charactersProvider.onDisplayCharacters.map((e) {
        List<AccountCharacter> filteredAccountCharacters = accountCharacters.where((element) => element.characterId == e.id).toList();
        if(filteredAccountCharacters.isEmpty){
          return AccountCharacterData(character: e, isBuilding: false, isPulled: false);
        } else {
          final accountCharacter = filteredAccountCharacters.first;
          return AccountCharacterData(
            character: e, 
            weapon: accountCharacter.weaponId,
            level: accountCharacter.level,
            basicTalentLevel: accountCharacter.basicTalentLevel.toString(),
            elementalTalentLevel: accountCharacter.elementalTalentLevel.toString(),
            burstTalentLevel: accountCharacter.burstTalentLevel.toString(),
            constellations: accountCharacter.constellations.toString(),
            isBuilding: accountCharacter.isBuilding, 
            isPulled: true
          );
        }
      })
    ];

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
          onTap: () {
            Navigator.pushNamed(context, 'character_form', arguments: e.character);
          },
          child: CharacterCard(
            data: e,
            maxWidth: cardMaxSize,
            aspectRatio: cardAspectRatio,
          ),
        )).toList(),
      )
    );
  }
}