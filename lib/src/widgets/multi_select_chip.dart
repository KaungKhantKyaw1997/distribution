import 'package:distribution/src/constants/color_constants.dart';
import 'package:flutter/material.dart';

class MultiSelectChip extends StatefulWidget {
  final List<String> dataList;
  final List<String> selectedChoices;
  final Function(List<String>) onSelectionChanged;
  MultiSelectChip(this.dataList, this.selectedChoices,
      {required this.onSelectionChanged});
  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  _buildChoiceList() {
    List<Widget> choices = [];
    widget.dataList.forEach(
      (item) {
        choices.add(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
              label: Text(
                item,
                style: widget.selectedChoices.contains(item)
                    ? Theme.of(context).textTheme.labelMedium
                    : Theme.of(context).textTheme.labelSmall,
              ),
              selected: widget.selectedChoices.contains(item),
              selectedColor: Theme.of(context).primaryColor,
              backgroundColor: ColorConstants.fillColor,
              checkmarkColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              side: BorderSide.none,
              onSelected: (selected) {
                setState(() {
                  widget.selectedChoices.contains(item)
                      ? widget.selectedChoices.remove(item)
                      : widget.selectedChoices.add(item);
                  widget.onSelectionChanged(widget.selectedChoices);
                });
              },
            ),
          ),
        );
      },
    );
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
