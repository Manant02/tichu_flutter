import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:velocity_x/velocity_x.dart';

class MyCheckBox extends StatelessWidget {
  const MyCheckBox({
    super.key,
    required this.value,
    this.onChanged,
    this.text,
  });

  final bool value;
  final void Function(bool?)? onChanged;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.black,
          fillColor:
              MaterialStateProperty.resolveWith((states) => Colors.yellow),
          value: value,
          onChanged: onChanged,
        ),
        if (text != null) 15.widthBox,
        if (text != null)
          Text(
            text!,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.yellow,
              fontSize: 15,
            ),
          )
      ],
    );
  }
}
