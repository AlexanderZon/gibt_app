import 'package:flutter/material.dart';
import 'package:gibt_1/models/models.dart';
import 'package:gibt_1/providers/account_characters_provider.dart';
import 'package:gibt_1/providers/characters_provider.dart';
import 'package:gibt_1/providers/weapons_provider.dart';
import 'package:gibt_1/widgets/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class CharacterWeaponSelectScreen extends StatelessWidget {
  const CharacterWeaponSelectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final columns = (size.width / 170).ceil();
    final double cardMaxWidth = size.width / columns - 20;

    final weaponsProvider = Provider.of<WeaponsProvider>(context, listen: true);
    final charactersProvider =
        Provider.of<CharactersProvider>(context, listen: true);
    final aaccountCharactersProvider =
        Provider.of<AccountCharactersProvider>(context, listen: true);

    final AccountCharacter accountCharacter =
        ModalRoute.of(context)!.settings.arguments as AccountCharacter;

    final weaponsList = weaponsProvider.onDisplayWeapons;
    final charactersList = charactersProvider.onDisplayCharacters;
    final character = charactersList.firstWhere(
      (element) => element.id == accountCharacter.characterId,
    );
    final actualWeapon = weaponsList.firstWhere(
      (element) => element.id == accountCharacter.weaponId,
    );

    BoxFit imageBoxFit = BoxFit.cover;
    List<Weapon> availableWeapons = [];
    // ignore: unnecessary_null_comparison
    if (character != null) {
      availableWeapons = weaponsList.where(
        (element) {
          return element.weaponType == character.weaponType;
        },
      ).toList();
      availableWeapons.sort(
        (a, b) {
          if (a.rarity > b.rarity) {
            return -1;
          } else if (a.rarity < b.rarity) {
            return 1;
          } else {
            return 0;
          }
        },
      );
      if (character.weaponType == WeaponType.CATALYST) {
        imageBoxFit = BoxFit.contain;
      }
    }

    const double cardAspectRatio = 0.9;
    final sideIconsSize = ((cardMaxWidth / cardAspectRatio) - 30) / 3;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weapon Select'),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: columns,
        childAspectRatio: cardAspectRatio,
        children: availableWeapons
            .map((e) => GestureDetector(
                  onTap: () {
                    accountCharacter.weaponId = e.id;
                    // ignore: unnecessary_null_comparison
                    if (actualWeapon != null &&
                        actualWeapon.rarity != e.rarity) {
                      accountCharacter.weapLevel = '1';
                      accountCharacter.weapRank = 1;
                    }
                    aaccountCharactersProvider.update(accountCharacter);
                    Navigator.pop(context);
                  },
                  child: GenericResourceCard(
                    data: GenericResourceCardData(
                        mainImage: 'assets/weapons/${e.id}_icon.webp',
                        text: e.name,
                        sideIcons: [
                          if (accountCharacter.weaponId != e.id)
                            GenericResourceCardSideIconData(
                                icon: MdiIcons.plusThick, color: Colors.blue),
                        ],
                        sideIconsSize: sideIconsSize,
                        stars: e.rarity),
                    maxWidth: cardMaxWidth,
                    faded: (accountCharacter.weaponId == e.id),
                    boxFit: imageBoxFit,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
