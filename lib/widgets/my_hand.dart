import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tichu_flutter/models/tichu_card.dart';
import 'package:tichu_flutter/widgets/tichu_card_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MyHand extends StatelessWidget {
  const MyHand({
    super.key,
    required this.hand,
    required this.selectedCards,
    this.selectMaxOne = false,
  });

  final List<TichuCard> hand;
  final ValueNotifier<List<bool>> selectedCards;
  final bool selectMaxOne;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, 1),
      child: Container(
        height: 140,
        child: Stack(
          children: hand.asMap().entries.map((handEntry) {
            final idx = handEntry.key;
            final len = hand.length;
            final x = 2 / (len - 1) * (idx) - 1;
            return Align(
              alignment: Alignment(x, selectedCards.value[idx] ? -1 : 1),
              child: SizedBox(
                height: 115,
                child: GestureDetector(
                  onTap: () {
                    if (selectMaxOne) {
                      selectedCards.value = List<bool>.generate(
                        selectedCards.value.length,
                        (i) => i == idx ? true : false,
                      );
                      return;
                    }
                    final updatedSelection = [...selectedCards.value];
                    updatedSelection[idx] = !updatedSelection[idx];
                    selectedCards.value = updatedSelection;
                  },
                  child: TichuCardWidget(
                    card: handEntry.value,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
