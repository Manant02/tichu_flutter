import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tichu_flutter/utils/extensions.dart';
import 'package:tichu_flutter/widgets/tichu_card_widget.dart';

import '../models/tichu_card.dart';

class TradingFields extends StatelessWidget {
  const TradingFields({
    super.key,
    required this.tradingCards,
    required this.selectedCards,
    required this.thisPlayerHandFiltered,
  });

  final ValueNotifier<List<TichuCard?>> tradingCards;
  final ValueNotifier<List<bool>> selectedCards;
  final List<TichuCard>? thisPlayerHandFiltered;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 0),
      child: SizedBox(
        width: 300,
        height: 115,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (!selectedCards.value.contains(true) ||
                    thisPlayerHandFiltered.isEmptyOrNull) return;

                placeSelectedCards(0);
              },
              child: TichuCardWidget(card: tradingCards.value[0]),
            ),
            GestureDetector(
              onTap: () {
                if (!selectedCards.value.contains(true) ||
                    thisPlayerHandFiltered.isEmptyOrNull) return;

                placeSelectedCards(1);
              },
              child: TichuCardWidget(card: tradingCards.value[1]),
            ),
            GestureDetector(
                onTap: () {
                  if (!selectedCards.value.contains(true) ||
                      thisPlayerHandFiltered.isEmptyOrNull) return;

                  placeSelectedCards(2);
                },
                child: TichuCardWidget(card: tradingCards.value[2])),
          ],
        ),
      ),
    );
  }

  void placeSelectedCards(int tradeSpotIdx) {
    final updatedTradingCards = [...tradingCards.value];
    updatedTradingCards[tradeSpotIdx] =
        thisPlayerHandFiltered!.boolFilter(selectedCards.value)[0];

    selectedCards.value = []; // to remove all selections
    tradingCards.value = updatedTradingCards;
  }
}
