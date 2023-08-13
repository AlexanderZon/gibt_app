import 'package:flutter/material.dart';
import 'package:gibt_1/models/models.dart';
import 'package:gibt_1/widgets/widgets.dart';

class FarmingMaterialsListSlider extends StatelessWidget {
  final List<FarmingMaterialData> list;
  const FarmingMaterialsListSlider({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return Container(
          margin: const EdgeInsets.only(bottom: 10),
          width: double.infinity,
          height: 150,
          alignment: Alignment.center,
          child: const Text('There is no data'));
    }

    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: double.infinity,
        height: 150,
        child: ListView.builder(
          itemCount: list.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, int index) =>
              FarmingMaterialResourceCard(data: list[index]),
        ));
  }
}

class FarmingMaterialResourceCard extends StatelessWidget {
  final FarmingMaterialData data;
  const FarmingMaterialResourceCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.items.isEmpty) {
      return GenericResourceCard(
          data: GenericResourceCardData(
              mainImage: 'assets/materials/${data.material.id}_icon.webp',
              text: '${data.quantity}',
              sideIcons: [],
              stars: data.material.rarity));
    } else {
      final firstAccountCharacter = data.items[0];
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'farming_material_details',
              arguments: data);
        },
        child: GenericResourceCard(
          data: GenericResourceCardData(
              mainImage: 'assets/materials/${data.material.id}_icon.webp',
              text: '${data.quantity}',
              sideIcons: [
                GenericResourceCardSideIconData(
                    image:
                        'assets/characters/${firstAccountCharacter.accountCharacter.characterId}_icon.webp'),
                if (firstAccountCharacter.type == 'weapon')
                  GenericResourceCardSideIconData(
                      image:
                          'assets/weapons/${firstAccountCharacter.accountCharacter.weaponId}_icon.webp',
                      hasMore: data.items.length > 1),
                if (firstAccountCharacter.type != 'weapon')
                  GenericResourceCardSideIconData(
                      image:
                          'assets/miscellaneous/${firstAccountCharacter.type}.webp',
                      hasMore: data.items.length > 1),
              ],
              stars: data.material.rarity),
          boxFit: BoxFit.contain,
        ),
      );
    }
  }
}
