import 'package:flutter/material.dart';
import 'package:notitia/utils.dart';

class Indicator extends StatelessWidget {
  final int positionIndex, currentIndex;
  const Indicator({this.currentIndex, this.positionIndex});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: 12,
      decoration: BoxDecoration(
          color:
              positionIndex == currentIndex ? Colors.white :convertToHex("#1B1C20"),
          borderRadius: BorderRadius.circular(100)),
    );
  }
}
