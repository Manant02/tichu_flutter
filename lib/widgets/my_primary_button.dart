import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MyPrimaryButton extends StatelessWidget {
  const MyPrimaryButton({
    Key? key,
    required this.onPressed,
    this.text,
    this.width,
    this.enabled = true,
  }) : super(key: key);

  final void Function() onPressed;
  final String? text;
  final double? width;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: enabled ? onPressed : () {},
      elevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      padding: const EdgeInsets.symmetric(vertical: 14),
      color: enabled ? Colors.yellow : Colors.yellow[700],
      // shape: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(100),
      //   borderSide: BorderSide.none,
      // ),
      minWidth: width ?? 160,
      child: text != null
          ? Text(
              text!,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: enabled ? Colors.black : Colors.black38,
              ),
            ).px(18)
          : null,
    );
  }
}
