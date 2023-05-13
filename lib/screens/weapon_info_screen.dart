import 'package:flutter/material.dart';
import 'package:gibt_1/models/models.dart';
import 'package:gibt_1/widgets/widgets.dart';

class WeaponInfoScreen extends StatelessWidget {
   
  const WeaponInfoScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    final Weapon weapon = ModalRoute.of(context)!.settings.arguments as Weapon;

    var titleStile = const TextStyle(color: Colors.white, fontFamily: 'Genshin', fontSize: 36);
    var textStyle = const TextStyle(color: Colors.white, fontFamily: 'Genshin', fontSize: 16);
    final String weaponType = weaponTypeValues.reverse[weapon.weaponType]!;
    const Widget spacer = SizedBox(height: 20,);

    return Scaffold(
      body: Stack(
        children: [
          _ScreenBackground(weapon: weapon),
          SingleChildScrollView(
            child: Column(
              children: [
                ElementHeaderSplashDisplayer(asset: 'assets/weapons/${weapon.id}_gacha_icon.webp'),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(weapon.name, style: titleStile,),
                      spacer,
                      Text('Type: $weaponType', style: textStyle,),
                      spacer,
                      Text('Ascension Materials: ', style: textStyle,),
                      ElementInfoMaterialsGrid(materials: weapon.ascensionMaterials),
                      spacer,
                      Text('Description:', style: textStyle,),
                      Text(weapon.description, style: textStyle,),
                    ],
                  )
                )
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
    super.key,
    required this.weapon,
  });

  final Weapon weapon;

  @override
  Widget build(BuildContext context) {
    return ElementInfoBackground(asset: 'assets/backgrounds/${weapon.rarity}-stars.png');
  }
}