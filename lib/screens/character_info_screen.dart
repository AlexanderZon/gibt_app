import 'package:flutter/material.dart';

class CharacterInfoScreen extends StatelessWidget {
   
  const CharacterInfoScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character Info'),
      ),
      body: Center(
        child: Text('CharacterInfoScreen'),
      ),
    );
  }
}