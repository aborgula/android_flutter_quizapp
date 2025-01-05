import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hci/configs/themes/app_colors.dart';
import 'package:hci/configs/themes/ui_parameters.dart';

class ContentArea extends StatelessWidget{
  final bool addPadding;
  final Widget child;
  final Color? color;
  const ContentArea({Key? key,

  required this.child,
  this.addPadding=true,
    this.color
  }) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.vertical(top:Radius.circular(20)),
      clipBehavior: Clip.hardEdge,
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
          color: color ?? customScaffoldColor(context)
        ),
        padding: addPadding? EdgeInsets.only(
          top: mobileScreenPadding,
          left: mobileScreenPadding,
          right: mobileScreenPadding
        ):EdgeInsets.zero,
        child: child
      ),
    );
  }
}