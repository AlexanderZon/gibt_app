import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppBottomNavigationBar extends StatefulWidget {
  final int currentState;
  final Function onTab;

  const AppBottomNavigationBar({
    super.key,
    required this.currentState,
    required this.onTab,
  });

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int currentState = 0;

  @override
  Widget build(BuildContext context) {
    currentState = widget.currentState;

    final List<BottomNavigationBarData> items = [
      BottomNavigationBarData(name: 'home', text: 'Home', icon: MdiIcons.home),
      BottomNavigationBarData(
          name: 'characters', text: 'Characters', icon: MdiIcons.account),
      BottomNavigationBarData(
          name: 'weapons', text: 'Weapons', icon: MdiIcons.bowArrow),
      BottomNavigationBarData(
          name: 'settings', text: 'Settings', icon: MdiIcons.cog),
    ];
    return BottomNavigationBar(
      currentIndex: currentState,
      selectedItemColor: Colors.indigo,
      unselectedItemColor: Colors.indigo.withAlpha(200),
      items: items
          .map((e) => BottomNavigationBarItem(
                icon: Icon(
                  e.icon,
                ),
                label: e.text,
              ))
          .toList(),
      onTap: (index) {
        widget.onTab(index);
      },
    );
  }
}

class BottomNavigationBarData {
  final String name;
  final String text;
  final IconData icon;

  BottomNavigationBarData(
      {required this.name, required this.text, required this.icon});
}
