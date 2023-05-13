import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gibt_1/models/models.dart';
import 'package:gibt_1/widgets/element_header_splash_displayer.dart';
import 'package:gibt_1/widgets/element_info_background.dart';

class FarmingMaterialDetailsScreen extends StatelessWidget {
  const FarmingMaterialDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final FarmingMaterialData material = ModalRoute.of(context)!.settings.arguments as FarmingMaterialData;
    
    final BorderRadius borderRadius = BorderRadius.circular(10);
    var titleStyle = const TextStyle(color: Colors.white, fontFamily: 'Genshin', fontSize: 36);
    var textStyle = const TextStyle(color: Colors.white, fontFamily: 'Genshin', fontSize: 16);
    const Widget spacer = SizedBox(height: 20,);

    return Scaffold(
      body: Stack(
        children: [
          _ScreenBackground(material: material.material,),
          SingleChildScrollView(
            child: Column(
              children: [
                ElementHeaderSplashDisplayer(asset: 'assets/materials/${material.material.id}_icon.webp'),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(material.material.name, style: titleStyle,),
                      Text('Needed for: ', style: textStyle,),
                      _FarmingMaterialDetailsGridViewer(material: material),
                      Text('Description: ', style: textStyle,),
                      Text('${material.material.description}', style: textStyle,),
                    ],
                  )
                )
              ]
            ),
          ),
        ],
      ),
    );
  }
}

class _FarmingMaterialDetailsGridViewer extends StatelessWidget {
  const _FarmingMaterialDetailsGridViewer({
    super.key,
    required this.material,
  });
  final FarmingMaterialData material;

  @override
  Widget build(BuildContext context) {

    final double spacing = 10;
    final int itemsCounter = 3;
    final itemDimensions = MediaQuery.of(context).size.width/itemsCounter+spacing;
    final itemHeight = itemDimensions*1;

    final height = (material.items.length/itemsCounter).ceil()*itemHeight;
    final imageHeight = itemHeight-30;

    var textStyle = const TextStyle(color: Colors.white, fontFamily: 'Genshin', fontSize: 16);
    
    return Container(
      height: height+40,
      padding: EdgeInsets.all(0),
      child: GridView.builder(
        primary: false,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: itemDimensions,
          mainAxisExtent: itemHeight,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: material.items.length,
        itemBuilder: (context, index) =>  ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: Color.fromARGB(125, 0, 0, 0),
              // color: Colors.red,
              padding: EdgeInsets.only(bottom: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: imageHeight,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Container(
                          child: Image(
                            image: AssetImage('assets/characters/${material.items[index].accountCharacter.character?.id}_icon.webp'),
                            width: double.infinity,
                            height: imageHeight,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Column(
                          children: [
                            Expanded(child: Container()),
                            Row(
                              children: [
                                Expanded(child: Container()),
                                if(material.items[index].type == 'weapon')
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5)),
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      color: Color.fromARGB(225, 0, 0, 0),
                                      child: Image(
                                        image: AssetImage('assets/weapons/${material.items[index].accountCharacter.weapon?.id}_icon.webp'),
                                        width: double.infinity,
                                      ),
                                    ),
                                  )
                                else
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5)),
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      color: Color.fromARGB(200, 0, 0, 0),
                                      child: Image(
                                        image: AssetImage('assets/miscellaneous/${material.items[index].type}.webp'),
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  ClipRRect(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                    child: Container(
                      height: 30,
                      width: double.infinity,
                      color: Color.fromARGB(200, 0, 0, 0),
                      alignment: Alignment.center,
                      child: Text('${material.items[index].quantity}', style: textStyle,),
                    ),
                  ),
                ],
              ),
            )
          )
      ),
    );
  }
}


class _ScreenBackground extends StatelessWidget {
  const _ScreenBackground({
    super.key,
    required this.material,
  });

  final MaterialItem material;

  @override
  Widget build(BuildContext context) {
    log('screen background ');
    log('rarity ${material.rarity}');
    return ElementInfoBackground(asset: 'assets/backgrounds/${material.rarity}-stars.png');
  }
}