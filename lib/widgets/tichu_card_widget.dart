import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tichu_flutter/models/tichu_card.dart';
import 'package:velocity_x/velocity_x.dart';

class TichuCardWidget extends StatelessWidget {
  const TichuCardWidget({super.key, this.card});

  final TichuCard? card;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2 / 3,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1.2, color: Colors.black),
        ),
        child: card != null
            ? Text(
                card!.str,
                style: TextStyle(fontWeight: FontWeight.w500),
              ).p(3)
            : null,
      ),
    );
  }
}
