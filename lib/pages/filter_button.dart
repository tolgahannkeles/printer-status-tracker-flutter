import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FilterButton extends StatefulWidget {
  Function() onFilterOff;
  Function() onFilterOn;
  FilterButton(
      {super.key, required this.onFilterOff, required this.onFilterOn});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  bool filterActived = false;
  late Function() onReact;
  @override
  void initState() {
    onReact = widget.onFilterOff;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          filterActived = !filterActived;
          if (filterActived) {
            onReact = widget.onFilterOff;
          } else {
            onReact = widget.onFilterOn;
          }
          onReact.call();
          setState(() {});
        },
        icon: filterActived
            ? const Icon(Icons.filter_alt_off_rounded)
            : const Icon(Icons.filter_alt_rounded));
  }
}
