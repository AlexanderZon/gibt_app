import 'package:flutter/material.dart';
import 'package:gibt_1/screens/screens.dart';
import 'package:gibt_1/widgets/widgets.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentState = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const CharactersScreen(),
    const WeaponsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentState, children: screens),
      bottomNavigationBar: AppBottomNavigationBar(
        currentState: currentState,
        onTab: (index) {
          setState(() {
            currentState = index;
          });
        },
      ),
    );
  }
}