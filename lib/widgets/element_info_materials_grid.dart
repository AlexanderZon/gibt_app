

import 'package:flutter/material.dart';
import 'package:gibt_1/models/ascension_material.dart';

class ElementInfoMaterialsGrid extends StatelessWidget {
  const ElementInfoMaterialsGrid({
    super.key,
    required this.materials,
  });

  final List<DescriptionAscensionMaterial> materials;

  @override
  Widget build(BuildContext context) {

    final double spacing = 10;
    final int itemsCounter = 5;
    final itemDimensions = MediaQuery.of(context).size.width/itemsCounter+spacing;

    return Container(
      height: (materials.length/5).ceil()*itemDimensions+20,
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        crossAxisCount: itemsCounter,
        childAspectRatio: 1,
        children: materials.map((e) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: Color.fromARGB(125, 0, 0, 0),
              padding: EdgeInsets.all(5),
              child: Image(
                image: AssetImage('assets/materials/${e.id}_icon.webp'),
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            )
          );
        }).toList(),
      ),
    );
  }
}
