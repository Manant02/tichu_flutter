import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tichu_flutter/widgets/tichu_card_widget.dart';

class MyHand extends StatelessWidget {
  const MyHand({
    super.key,
    required this.hand,
  });

  final List<String> hand;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 1),
      child: Container(
        height: 120,
        child: Stack(
          children: hand.asMap().entries.map((entry) {
            final idx = entry.key;
            final len = hand.length;
            final x = 2 / (len - 1) * (idx) - 1;
            return Align(
              alignment: Alignment(x, 0),
              child: TichuCardWidget(
                card: entry.value,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
