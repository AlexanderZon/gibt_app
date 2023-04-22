
import 'dart:developer';

import 'package:flutter/material.dart';

class SliderOptionsPicker extends StatefulWidget {
  const SliderOptionsPicker({
    super.key,
    required this.options,
    required this.label,
    required this.formProperty,
    required this.formValues,
    this.initialValue, 
    required this.onChange,
  });

  final List<dynamic> options;
  final String label;
  final dynamic formProperty;
  final Map<String, dynamic> formValues;
  final String? initialValue;
  final Function onChange;

  @override
  State<SliderOptionsPicker> createState() => _SliderOptionsPickerState();
}

class _SliderOptionsPickerState extends State<SliderOptionsPicker> {

  final ScrollController scrollController = new ScrollController();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // log('init state');
    scrollController.addListener(() {
      // log(scrollController.position.activity!.isScrolling);
      // log('${scrollController.position.pixels} ${scrollController.position.maxScrollExtent}');
    });
  }

  @override
  Widget build(BuildContext context) {
    // if(widget.formValues[widget.formProperty] == '') widget.formValues[widget.formProperty] = widget.initialValue ?? widget.defaultValue;
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              widget.label,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: double.infinity,
            height: 50,
            // decoration: BoxDecoration(border: Border.symmetric(horizontal: BorderSide(color: Colors.indigo.withAlpha(128)))),
            child: NotificationListener(
              onNotification: (t) {
                 if (t is ScrollEndNotification) {
                  // log('End Notification: ${scrollController.position.pixels} ${scrollController.position.maxScrollExtent}');
                }
                return false;
              },
              child: ListView.builder(
                itemCount: widget.options.length,
                scrollDirection: Axis.horizontal,
                controller: scrollController,
                itemBuilder: (context, int index){
                  if(widget.options[index] == widget.formValues[widget.formProperty]){
                    return TextButton(
                      onPressed: () {}, 
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),
                      ),
                      child: Text('${widget.options[index]}', style: const TextStyle(color: Colors.white),)
                    );
                  }
                  return TextButton(
                    onPressed: () {
                      setState(() {
                        widget.formValues[widget.formProperty] = widget.options[index];
                        widget.onChange();
                      });
                    }, 
                    child: Text('${widget.options[index]}', style: const TextStyle(color: Colors.indigo),)
                  );
                },
              ),
            )
          )
        ],
      ),
    );
  }
}
