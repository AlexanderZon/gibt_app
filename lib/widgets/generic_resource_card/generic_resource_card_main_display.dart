import 'package:flutter/material.dart';
import 'package:gibt_1/widgets/generic_resource_card/widgets.dart';

class GenericResourceCardMainDisplay extends StatelessWidget {
  final GenericResourceCardData card;

  final double? maxWidth;
  final bool? faded;
  final BoxFit? boxFit;

  const GenericResourceCardMainDisplay({
    super.key,
    required this.card,
    this.maxWidth,
    this.faded,
    this.boxFit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container()),
        MainDisplay(
          image: card.mainImage,
          text: card.text,
          stars: card.stars,
          maxWidth: maxWidth,
          faded: faded,
          boxFit: boxFit,
        ),
      ],
    );
  }
}

class MainDisplay extends StatelessWidget {
  final int stars;
  final String text;
  final String image;
  final double? maxWidth;
  final bool? faded;
  final BoxFit? boxFit;

  const MainDisplay({
    super.key,
    required this.stars,
    required this.text,
    required this.image,
    this.maxWidth,
    this.faded,
    this.boxFit,
  });

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(10);

    final double width = maxWidth != null ? maxWidth! - 10 : 120;
    final bool isFaded = faded != null ? faded! : false;
    final BoxFit boxFit = this.boxFit != null ? this.boxFit! : BoxFit.contain;

    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
      ),
      height: double.infinity,
      width: width,
      child: Stack(children: [
        ClipRRect(
            borderRadius: borderRadius,
            child: Image(
              image: AssetImage('assets/miscellaneous/${stars}star.webp'),
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            )),
        ClipRRect(
            borderRadius: borderRadius,
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: AssetImage(image),
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
              fit: boxFit,
            )),
        ClipRRect(
          borderRadius: borderRadius,
          child: Column(
            children: [
              Expanded(child: Container()),
              SizedBox(
                width: double.infinity,
                height: 30,
                child: Container(
                    color: Colors.black.withAlpha(128),
                    alignment: Alignment.center,
                    height: double.infinity,
                    width: double.infinity,
                    child: Text(text,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Genshin',
                          color: Colors.white,
                          fontSize: 17,
                        ))),
              ),
            ],
          ),
        ),
        if (isFaded)
          ClipRRect(
            borderRadius: borderRadius,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withAlpha(120),
            ),
          ),
      ]),
    );
  }
}
