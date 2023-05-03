import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tichu_flutter/models/enums.dart';
import 'package:tichu_flutter/widgets/tichu_card_widget.dart';

class OtherHand extends StatelessWidget {
  const OtherHand({
    super.key,
    required this.hand,
    required this.tablePos,
  });

  final List<String> hand;
  final TablePos tablePos;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: tablePos == TablePos.teamMate
          ? const Alignment(0, -0.76)
          : tablePos == TablePos.OppRight
              ? const Alignment(1, -0.33)
              : tablePos == TablePos.OppLeft
                  ? const Alignment(-1, -0.33)
                  : tablePos == TablePos.thisPlayer
                      ? const Alignment(0, 0.6)
                      : const Alignment(0, 0),
      child: Container(
        height: 70,
        width: 180,
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
