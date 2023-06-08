import 'package:flutter/material.dart';
import 'package:gibt_1/models/models.dart';
import 'package:gibt_1/widgets/widgets.dart';

class CharacterInfoScreen extends StatelessWidget {
  const CharacterInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Character character =
        ModalRoute.of(context)!.settings.arguments as Character;

    var titleStile = const TextStyle(
        color: Colors.white, fontFamily: 'Genshin', fontSize: 36);
    var textStyle = const TextStyle(
        color: Colors.white, fontFamily: 'Genshin', fontSize: 16);
    final String weaponType = weaponTypeValues.reverse[character.weaponType]!;
    final String birthDate =
        '${character.monthOfBirth}/${character.dayOfBirth}';
    const Widget spacer = SizedBox(
      height: 20,
    );
    return Scaffold(
      body: Stack(
        children: [
          _ScreenBackground(character: character),
          SingleChildScrollView(
            child: Column(
              children: [
                ElementHeaderSplashDisplayer(
                    asset:
                        'assets/characters/${character.id}_gacha_splash.webp'),
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          character.name,
                          style: titleStile,
                        ),
                        spacer,
                        Text(
                          'Title: ${character.title}',
                          style: textStyle,
                        ),
                        Text(
                          'Occupation: ${character.occupation}',
                          style: textStyle,
                        ),
                        Text(
                          'Weapon: $weaponType',
                          style: textStyle,
                        ),
                        Text(
                          'Birth Date: $birthDate',
                          style: textStyle,
                        ),
                        spacer,
                        Text(
                          'Ascension Materials: ',
                          style: textStyle,
                        ),
                        ElementInfoMaterialsGrid(
                            materials: character.ascensionMaterials),
                        Text(
                          'Skill Ascension Materials: ',
                          style: textStyle,
                        ),
                        ElementInfoMaterialsGrid(
                            materials: character.skillAscensionMaterials),
                        spacer,
                        Text(
                          'Description:',
                          style: textStyle,
                        ),
                        Text(
                          character.description,
                          style: textStyle,
                        ),
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ScreenBackground extends StatelessWidget {
  const _ScreenBackground({
    // ignore: unused_element
    super.key,
    required this.character,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    return ElementInfoBackground(
        asset:
            'assets/backgrounds/${visionValues.reverse[character.vision]}.png');
  }
}
