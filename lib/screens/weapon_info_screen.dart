import 'package:flutter/material.dart';

class WeaponInfoScreen extends StatelessWidget {
   
  const WeaponInfoScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weapon Info'),
      ),
      body: Center(
        child: Text('WeaponInfoScreen'),
      ),
    );
  }
}