import 'package:flutter/material.dart';
import 'package:gibt_1/widgets/generic_resource_card/widgets.dart';

class GenericResourceCard extends StatelessWidget {
  final GenericResourceCardData data;

  final double? maxWidth;
  final bool? faded;
  final BoxFit? boxFit;

  const GenericResourceCard({
    super.key,
    required this.data,
    this.maxWidth,
    this.faded,
    this.boxFit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: maxWidth ?? 130,
      child: Stack(
        children: [
          GenericResourceCardMainDisplay(
            card: data,
            maxWidth: maxWidth,
            faded: faded,
            boxFit: boxFit,
          ),
          GenericResourceCardSideIcons(
              sideIcons: data.sideIcons, sideIconsSize: data.sideIconsSize)
        ],
      ),
    );
  }
}

class GenericResourceCardData {
  final String mainImage;
  final int stars;
  final String text;
  final List<GenericResourceCardSideIconData> sideIcons;
  final double? sideIconsSize;

  GenericResourceCardData({
    required this.mainImage,
    required this.text,
    required this.sideIcons,
    required this.stars,
    this.sideIconsSize,
  });
}
