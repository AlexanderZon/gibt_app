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
    final todayMaterials = homeProvider.farmingTodayMaterials;
    final bossMaterials = homeProvider.farmingBossMaterials;
    final elementalStones = homeProvider.farmingElementalStones;
    final charJewels = homeProvider.farmingCharJewels;
    final localMaterials = homeProvider.farmingLocalMaterials;
    final secondaryMaterials = homeProvider.farmingSecondaryMaterials;
    final commonMaterials = homeProvider.farmingCommonMaterials;

    log('home screen bossMaterials ${bossMaterials.length}');
    
    if(homeProvider.loading) return Scaffold(
      appBar: AppBar(),
      body: Center(child: CircularProgressIndicator(value: null))
    );
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Farming for Today', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                IconButton(
                  onPressed: homeProvider.canSubDay ? () => homeProvider.subFarmingDay() : null, 
                  icon: Icon(Icons.chevron_left)
                ),
                Column(
                  children: [
                    Text(homeProvider.farmingDateDay, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                    Text(homeProvider.farmingDate, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),),
                  ],
                ),
                IconButton(
                  onPressed: homeProvider.canAddDay ? () => homeProvider.addFarmingDay() : null, 
                  icon: Icon(Icons.chevron_right)
                ),
              ],
            ),
            FarmingMaterialsListSlider(list: todayMaterials,),
            
            HomeSlidersLabel(text: 'Boss Materials',),
            FarmingMaterialsListSlider(list: bossMaterials,),

            HomeSlidersLabel(text: 'Elemental Stones',),
            FarmingMaterialsListSlider(list: elementalStones,),

            HomeSlidersLabel(text: 'Char Jewels',),
            FarmingMaterialsListSlider(list: charJewels,),

            HomeSlidersLabel(text: 'Local Materials',),
            FarmingMaterialsListSlider(list: localMaterials,),

            HomeSlidersLabel(text: 'Secondary Materials',),
            FarmingMaterialsListSlider(list: secondaryMaterials,),

            HomeSlidersLabel(text: 'Common Materials',),
            FarmingMaterialsListSlider(list: commonMaterials,),
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
