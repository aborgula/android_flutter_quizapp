import 'package:flutter/cupertino.dart';

class AppIconText extends StatelessWidget{
  final Icon icon;
  final Widget text;
  const AppIconText({Key? key,
  required this.icon, required this.text
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(
          width: 4,
        ),
        text
      ],
    );
  }
}