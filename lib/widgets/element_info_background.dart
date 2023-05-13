

import 'package:flutter/material.dart';

class ElementInfoBackground extends StatelessWidget {
  const ElementInfoBackground({
    super.key,
    required this.asset,
  });

  final String asset;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Text(''),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(Colors.white.withOpacity(1), BlendMode.dstATop),
          image: AssetImage(asset)
        )
      ),
    );
  }
}