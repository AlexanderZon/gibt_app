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
    this.slotActions,
  });

  final List<dynamic> options;
  final String label;
  final dynamic formProperty;
  final Map<String, dynamic> formValues;
  final String? initialValue;
  final Function onChange;
  final Widget? slotActions;

  @override
  State<SliderOptionsPicker> createState() => _SliderOptionsPickerState();
}

class _SliderOptionsPickerState extends State<SliderOptionsPicker> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double optionHeight = 50;
    double optionWidth = 50;
    double sideSlackWidth = width / 2 - (optionWidth / 2);

    var index = widget.options.indexWhere(
        (element) => element == widget.formValues[widget.formProperty]);
    final ScrollController scrollController =
        ScrollController(initialScrollOffset: index * optionWidth);

    @override
    void initState() {
      super.initState();
      scrollController.addListener(() {
        //
      });
    }

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.label,
                  style: const TextStyle(fontSize: 16, fontFamily: "Genshin"),
                ),
                if (widget.slotActions != null) widget.slotActions!,
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: double.infinity,
              height: 50,
              // decoration: BoxDecoration(border: Border.symmetric(horizontal: BorderSide(color: Colors.indigo.withAlpha(128)))),
              child: Stack(
                children: [
                  SizedBox(
                    height: double.infinity,
                    child: Row(children: [
                      SizedBox(
                        width: sideSlackWidth,
                        height: optionHeight,
                      ),
                      SizedBox(
                        width: optionWidth,
                        height: optionHeight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.indigo, width: 2),
                            color: Colors.indigo.withOpacity(.25),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  NotificationListener(
                    onNotification: (t) {
                      if (t is ScrollEndNotification) {
                        double actualValue =
                            (scrollController.position.pixels) / optionWidth;
                        var nextIntValue = actualValue.ceil();
                        var previousIntValue = actualValue.floor();
                        int nextOption = 0;
                        if ((nextIntValue - actualValue) <
                            (actualValue - previousIntValue)) {
                          nextOption = nextIntValue;
                        } else {
                          nextOption = previousIntValue;
                        }
                        // Set selected option on state
                        setState(() {
                          widget.formValues[widget.formProperty] =
                              widget.options[nextOption];
                          widget.onChange();
                        });
                        // Set selected option visible
                        try {
                          scrollController.position
                              .setPixels(nextOption * optionWidth);
                        } catch (_AssertionError) {
                          //
                        }
                      }
                      return false;
                    },
                    child: ListView.builder(
                      itemCount: widget.options.length + 2,
                      scrollDirection: Axis.horizontal,
                      controller: scrollController,
                      itemBuilder: (context, int index) {
                        if (index == 0) {
                          return SizedBox(
                            width: sideSlackWidth,
                          );
                        }
                        if (index == widget.options.length + 1) {
                          return SizedBox(
                            width: sideSlackWidth,
                          );
                        }
                        int optionIndex = index - 1;
                        return SizedBox(
                            width: optionWidth,
                            height: optionWidth,
                            child: Center(
                                child: Text(
                              '${widget.options[optionIndex]}',
                              style: const TextStyle(
                                  color: Colors.indigo,
                                  fontFamily: "Genshin",
                                  fontSize: 14),
                            )));
                      },
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
