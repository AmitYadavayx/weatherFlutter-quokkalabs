import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.center});
  final dynamic center;
  @override
  Widget build(BuildContext context) {
    return center==null?const CircularProgressIndicator():const Center(child: CircularProgressIndicator(),);
  }
}
