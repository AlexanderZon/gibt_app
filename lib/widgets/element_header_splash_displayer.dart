import 'package:flutter/material.dart';
import 'package:gibt_1/models/character.dart';

class ElementHeaderSplashDisplayer extends StatelessWidget {
  const ElementHeaderSplashDisplayer({
    super.key,
    required this.asset,
  });

  final String asset;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 250,
          decoration: const BoxDecoration(
            color: Color.fromARGB(125, 0, 0, 0),
          ),
          child: Image.asset(asset),
        ),
        Container(
          width: double.infinity,
          height: 250,
          child: Column(
            children: [
              const SizedBox(height: 50,),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.white,)
                  ),
                  Expanded(child: Container())
                ],
              ),
              Expanded(child: Container())
            ],
          ),
        ),

      ],
    );
  }
}