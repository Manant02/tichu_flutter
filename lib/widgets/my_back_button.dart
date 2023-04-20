import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({
    Key? key,
    this.text = 'Back',
    this.onTap,
  }) : super(key: key);

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            Navigator.of(context).pop();
          },
      child: Row(
        children: [
          const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.yellow,
            size: 25,
          ),
          Text(
            text,
            style: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.w600,
                fontSize: 18),
          ).p(5)
        ],
      ).p(6),
    );
  }
}
