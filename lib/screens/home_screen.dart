import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gibt_1/providers/home_provider.dart';
import 'package:gibt_1/widgets/widgets.dart';
import 'package:gibt_1/models/models.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final homeProvider = Provider.of<HomeProvider>(context);
    final bossMaterials = homeProvider.farmingBossMaterials;
    final elementalStones = homeProvider.farmingElementalStones;
    final charJewels = homeProvider.farmingCharJewels;
    final localMaterials = homeProvider.farmingLocalMaterials;

    log('home screen bossMaterials ${bossMaterials.length}');
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if(homeProvider.loading) Text('is loading'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Farming for Today', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                IconButton(onPressed: () {}, icon: Icon(Icons.chevron_left)),
                Text('2023/04/09',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                IconButton(onPressed: () {}, icon: Icon(Icons.chevron_right)),
              ],
            ),
            FarmingMaterialsListSlider(list: [],),
            
            HomeSlidersLabel(text: 'Boss Materials',),
            FarmingMaterialsListSlider(list: bossMaterials,),

            HomeSlidersLabel(text: 'Elemental Stones',),
            FarmingMaterialsListSlider(list: elementalStones,),

            HomeSlidersLabel(text: 'Char Jewels',),
            FarmingMaterialsListSlider(list: charJewels,),

            HomeSlidersLabel(text: 'Local Materials',),
            FarmingMaterialsListSlider(list: localMaterials,),
          ],
        ),
      )
    );
  }
}

class HomeSlidersLabel extends StatelessWidget {

  final String text;
  
  const HomeSlidersLabel({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
        ],
      ),
    );
  }
}
