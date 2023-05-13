

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gibt_1/models/models.dart';
import 'package:gibt_1/models/weapon.dart';
import 'package:gibt_1/widgets/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class WeaponCard extends StatelessWidget {

  final AccountWeaponData data;
  final double maxWidth;
  final double aspectRatio;

  const WeaponCard({super.key, required this.data, required this.maxWidth, required this.aspectRatio});

  @override
  Widget build(BuildContext context) {

    final sideIconsSize = ((maxWidth/aspectRatio)-30)/3;

    BoxFit boxFit = BoxFit.cover;
    if(data.weapon.weaponType == WeaponType.CATALYST) boxFit = BoxFit.contain;
    if(data.isPulled && data.isBuilding){
      return GenericResourceCard(
        data: GenericResourceCardData(
          mainImage: 'assets/weapons/${data.weapon.id}_icon.webp', 
          text: data.weapon.name, 
          sideIcons: [
            GenericResourceCardSideIconData(image: 'assets/characters/${data.character.id}_icon.webp'),
            GenericResourceCardSideIconData(text: data.level),
            GenericResourceCardSideIconData(icon: MdiIcons.tools, color: Colors.green),
          ], 
          sideIconsSize: sideIconsSize,
          stars: data.weapon.rarity
        ),
        maxWidth: maxWidth,
        boxFit: boxFit,
      );
    } else if(data.isPulled) {
      return GenericResourceCard(
        data: GenericResourceCardData(
          mainImage: 'assets/weapons/${data.weapon.id}_icon.webp', 
          text: data.weapon.name, 
          sideIcons: [
            if(data.character != null)
              GenericResourceCardSideIconData(image: 'assets/characters/${data.character.id}_icon.webp'),
            if(data.level != null)
              GenericResourceCardSideIconData(text: data.level),
          ], 
          sideIconsSize: sideIconsSize,
          stars: data.weapon.rarity
        ),
        maxWidth: maxWidth,
        boxFit: boxFit,
      );
    } else { 
      return GenericResourceCard(
        data: GenericResourceCardData(
          mainImage: 'assets/weapons/${data.weapon.id}_icon.webp', 
          text: data.weapon.name, 
          sideIcons: [
            GenericResourceCardSideIconData(icon: MdiIcons.plusThick, color: Colors.blue),
          ], 
          sideIconsSize: sideIconsSize,
          stars: data.weapon.rarity
        ),
        maxWidth: maxWidth,
        faded: true,
        boxFit: boxFit,
      );
    }
  }
}

class AccountWeaponData {
  
  final Weapon weapon;
  final bool isBuilding;
  final bool isPulled;
  final String level;
  final String? constellations;
  final String? basicTalentLevel;
  final String? elementalTalentLevel;
  final String? burstTalentLevel;
  final Character character;

  AccountWeaponData({ 
    required this.weapon, 
    required this.isBuilding,
    required this.isPulled,
    required this.character, 
    required this.level,
    this.constellations, 
    this.basicTalentLevel, 
    this.elementalTalentLevel, 
    this.burstTalentLevel
  });
}