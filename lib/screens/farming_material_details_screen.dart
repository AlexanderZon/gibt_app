import 'package:flutter/material.dart';
import 'package:gibt_1/models/models.dart';
import 'package:gibt_1/widgets/element_header_splash_displayer.dart';
import 'package:gibt_1/widgets/element_info_background.dart';

class FarmingMaterialDetailsScreen extends StatelessWidget {
  const FarmingMaterialDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FarmingMaterialData material =
        ModalRoute.of(context)!.settings.arguments as FarmingMaterialData;

    var titleStyle = const TextStyle(
        color: Colors.white, fontFamily: 'Genshin', fontSize: 36);
    var textStyle = const TextStyle(
        color: Colors.white, fontFamily: 'Genshin', fontSize: 16);

    return Scaffold(
      body: Stack(
        children: [
          _ScreenBackground(
            material: material.material,
          ),
          SingleChildScrollView(
            child: Column(children: [
              ElementHeaderSplashDisplayer(
                  asset: 'assets/materials/${material.material.id}_icon.webp'),
              Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        material.material.name,
                        style: titleStyle,
                      ),
                      Text(
                        'Needed for: ',
                        style: textStyle,
                      ),
                      _FarmingMaterialDetailsGridViewer(material: material),
                      Text(
                        'Description: ',
                        style: textStyle,
                      ),
                      Text(
                        material.material.description,
                        style: textStyle,
                      ),
                    ],
                  ))
            ]),
          ),
        ],
      ),
    );
  }
}

class _FarmingMaterialDetailsGridViewer extends StatelessWidget {
  const _FarmingMaterialDetailsGridViewer({
    // ignore: unused_element
    super.key,
    required this.material,
  });
  final FarmingMaterialData material;

  @override
  Widget build(BuildContext context) {
    const double spacing = 10;
    const int itemsCounter = 3;
    final itemDimensions =
        MediaQuery.of(context).size.width / itemsCounter + spacing;
    final itemHeight = itemDimensions * 1;

    final height = (material.items.length / itemsCounter).ceil() * itemHeight;
    final imageHeight = itemHeight - 30;

    var textStyle = const TextStyle(
        color: Colors.white, fontFamily: 'Genshin', fontSize: 16);
    final BorderRadius borderRadius = BorderRadius.circular(10);

    return Container(
      height: height + 40,
      padding: const EdgeInsets.all(0),
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
          itemBuilder: (context, index) => ClipRRect(
              borderRadius: borderRadius,
              child: Container(
                color: const Color.fromARGB(125, 0, 0, 0),
                // color: Colors.red,
                padding: const EdgeInsets.only(bottom: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: imageHeight,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Image(
                            image: AssetImage(
                                'assets/characters/${material.items[index].accountCharacter.character?.id}_icon.webp'),
                            width: double.infinity,
                            height: imageHeight,
                            fit: BoxFit.fitHeight,
                          ),
                          Column(
                            children: [
                              Expanded(child: Container()),
                              Row(
                                children: [
                                  Expanded(child: Container()),
                                  if (material.items[index].type == 'weapon')
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(5)),
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        color:
                                            const Color.fromARGB(225, 0, 0, 0),
                                        child: Image(
                                          image: AssetImage(
                                              'assets/weapons/${material.items[index].accountCharacter.weapon?.id}_icon.webp'),
                                          width: double.infinity,
                                        ),
                                      ),
                                    )
                                  else
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(5)),
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        color:
                                            const Color.fromARGB(200, 0, 0, 0),
                                        child: Image(
                                          image: AssetImage(
                                              'assets/miscellaneous/${material.items[index].type}.webp'),
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
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      child: Container(
                        height: 30,
                        width: double.infinity,
                        color: const Color.fromARGB(200, 0, 0, 0),
                        alignment: Alignment.center,
                        child: Text(
                          '${material.items[index].quantity}',
                          style: textStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}

class _ScreenBackground extends StatelessWidget {
  const _ScreenBackground({
    // ignore: unused_element
    super.key,
    required this.material,
  });

  final MaterialItem material;

  @override
  Widget build(BuildContext context) {
    return ElementInfoBackground(
        asset: 'assets/backgrounds/${material.rarity}-stars.png');
  }
}
