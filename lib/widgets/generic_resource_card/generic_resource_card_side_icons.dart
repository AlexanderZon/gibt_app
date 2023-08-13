import 'package:flutter/material.dart';

class GenericResourceCardSideIcons extends StatelessWidget {
  final List<GenericResourceCardSideIconData> sideIcons;
  final double? sideIconsSize;

  const GenericResourceCardSideIcons({
    super.key,
    required this.sideIcons,
    this.sideIconsSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sideIcons
          .map((e) =>
              GenericResourceCardSideIconItem(data: e, size: sideIconsSize))
          .toList(),
    );
  }
}

class GenericResourceCardSideIconItem extends StatelessWidget {
  final GenericResourceCardSideIconData data;
  final double? size;

  const GenericResourceCardSideIconItem({
    super.key,
    required this.data,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final size = this.size ?? 40;
    final double fontSize = size / 2 - 3;
    final double iconSize = size / 2 + 3;

    Widget getWidget() {
      if (data.image != null) {
        return FadeInImage(
            placeholder: const AssetImage('assets/no-image.jpg'),
            image: AssetImage(data.image!));
      } else if (data.text != null) {
        return Center(
          child: Text(
            data.text!,
            style: TextStyle(
                color: Colors.white, fontFamily: 'Genshin', fontSize: fontSize),
          ),
        );
      } else if (data.icon != null) {
        return Center(
            child: Icon(
          data.icon,
          color: Colors.white,
          size: iconSize,
        ));
      } else {
        return Container();
      }
    };

    return Stack(
      children: [
        Container(
            height: size,
            width: size,
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: data.color ?? Colors.black,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: getWidget(),
            )),
        if (data.hasMore == true)
          SizedBox(
            height: size + 3,
            width: size + 3,
            child: Column(
              children: [
                Expanded(child: Container()),
                Row(
                  children: [
                    Expanded(child: Container()),
                    Container(
                      height: size / 2,
                      width: size / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: data.color ?? Colors.black,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Center(
                            child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: iconSize / 2,
                        )),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
      ],
    );
  }
}

class GenericResourceCardSideIconData {
  final String? image;
  final String? text;
  final IconData? icon;
  final Color? color;
  bool? hasMore = false;
  GenericResourceCardSideIconData(
      {this.image, this.text, this.icon, this.color, this.hasMore});
}
