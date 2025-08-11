import 'package:beggining/factory/color_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_progress_indicator/flutter_circular_progress_indicator.dart';

class CircularProgressIndicatorClass {
  final CircularProgressIndicator circularProgressIndicator;
  CircularProgressIndicatorClass({required this.circularProgressIndicator});

  Widget cPI() {
    return CircularProgressInd().normalCircular(
        height: 55,
        width: 55,
        value: .4,
        isSpining: true,
        hasSpinReverse: true,
        valueColor: ColorFactory.background,
        secondaryColor: ColorFactory.primary,
        secondaryWidth: 10,
        valueWidth: 6);
  }
}
