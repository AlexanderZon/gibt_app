

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gibt_1/models/character.dart';
import 'package:gibt_1/widgets/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CharacterCard extends StatelessWidget {

  final AccountCharacterData data;
  final double maxWidth;
  final double aspectRatio;

  const CharacterCard({super.key, required this.data, required this.maxWidth, required this.aspectRatio});

  @override
  Widget build(BuildContext context) {

    final sideIconsSize = ((maxWidth/aspectRatio)-30)/3;
    if(data.isPulled && data.isBuilding){
      return GenericResourceCard(
        data: GenericResourceCardData(
          mainImage: 'assets/characters/${data.character.id}_icon.webp', 
          text: data.character.name, 
          sideIcons: [
            if(data.weapon != null)
              GenericResourceCardSideIconData(image: 'assets/weapons/${data.weapon}_icon.webp'),
            if(data.level != null)
              GenericResourceCardSideIconData(text: data.level),
            GenericResourceCardSideIconData(icon: MdiIcons.tools, color: Colors.green),
          ], 
          sideIconsSize: sideIconsSize,
          stars: data.character.rarity
        ),
        maxWidth: maxWidth,
        boxFit: BoxFit.cover,
      );
    } else if(data.isPulled) {
      return GenericResourceCard(
        data: GenericResourceCardData(
          mainImage: 'assets/characters/${data.character.id}_icon.webp', 
          text: data.character.name, 
          sideIcons: [
            if(data.weapon != null)
              GenericResourceCardSideIconData(image: 'assets/weapons/${data.weapon}_icon.webp'),
            if(data.level != null)
              GenericResourceCardSideIconData(text: data.level),
          ], 
          sideIconsSize: sideIconsSize,
          stars: data.character.rarity
        ),
        maxWidth: maxWidth,
        boxFit: BoxFit.cover,
      );
    } else { 
      return GenericResourceCard(
        data: GenericResourceCardData(
          mainImage: 'assets/characters/${data.character.id}_icon.webp', 
          text: data.character.name, 
          sideIcons: [
            GenericResourceCardSideIconData(icon: MdiIcons.plusThick, color: Colors.blue),
          ], 
          sideIconsSize: sideIconsSize,
          stars: data.character.rarity
        ),
        maxWidth: maxWidth,
        faded: true,
        boxFit: BoxFit.cover,
      );
    }
  }
}

class AccountCharacterData {
  
  final Character character;
  final bool isBuilding;
  final bool isPulled;
  final String? level;
  final String? constellations;
  final String? basicTalentLevel;
  final String? elementalTalentLevel;
  final String? burstTalentLevel;
  final String? weapon;

  AccountCharacterData({ 
    required this.character, 
    required this.isBuilding,
    required this.isPulled,
    this.weapon, 
    this.level,
    this.constellations, 
    this.basicTalentLevel, 
    this.elementalTalentLevel, 
    this.burstTalentLevel
  });
}