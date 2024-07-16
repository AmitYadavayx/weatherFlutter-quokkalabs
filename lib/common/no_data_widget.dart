import 'package:flutter/material.dart';
import 'package:weather_app/custom_widgets/custom_text.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key, this.center});
  final dynamic center;
  @override
  Widget build(BuildContext context) {
    return center==null?const HeadingText("No Data"):const Center(child: HeadingText("No Data"),);
  }
}
