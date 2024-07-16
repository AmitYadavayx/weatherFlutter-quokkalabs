import 'package:flutter/material.dart';
import 'package:weather_app/custom_widgets/custom_text.dart';

class AppBarCommon extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCommon({super.key, this.title, this.actions, this.elevation, this.leading, this.height, this.backgroundColor});
  final dynamic title;
  final List<Widget>? actions;
  final double? elevation;
  final Widget? leading;
  final double? height;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      leading: leading,
        title: title.runtimeType!=String?title:NormalHeadingText(title),
      actions: actions,
      centerTitle: true,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>Size.fromHeight(height??kToolbarHeight);
}
