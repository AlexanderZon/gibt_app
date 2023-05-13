import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({
    super.key,
    required this.formValues, 
    required this.formProperty,
    required this.label, 
    required this.onChange,
  });

  final Map<String, dynamic> formValues;
  final String formProperty;
  final String label;
  final Function onChange;

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      // Thumb icon when the switch is selected.
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
      // This bool value toggles the switch.
      value: widget.formValues[widget.formProperty],
      activeColor: Colors.indigo,
      title: Text(
        widget.label,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      
      onChanged: (bool value) {
        // This is called when the user toggles the switch.
        setState(() {
          widget.formValues[widget.formProperty] = !widget.formValues[widget.formProperty];
          widget.onChange();
        });
      },
    );
  }
}
