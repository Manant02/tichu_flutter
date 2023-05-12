import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tichu_flutter/models/tichu_game.dart';

import '../models/enums.dart';
import '../models/tichu_card.dart';
import '../services/firestore.dart';
import '../utils/show_platform_alert_dialog.dart';
import 'my_primary_button.dart';

class TradeButton extends StatelessWidget {
  const TradeButton({
    super.key,
    required this.game,
    required this.thisPlayerNr,
    required this.cards,
    required this.thisPlayerHasTraded,
  });

  final TichuGame game;
  final PlayerNr thisPlayerNr;
  final List<TichuCard?> cards;
  final ValueNotifier<bool> thisPlayerHasTraded;

  @override
  Widget build(BuildContext context) {
    final firestore = Firestore();
    return Align(
      alignment: const Alignment(0, 0.32),
      child: MyPrimaryButton(
        enabled: !cards.contains(null),
        enabledColor: Colors.blue,
        disabledColor: Colors.blue[700],
        text: 'Trade',
        onPressed: () async {
          final sr = await firestore.makeTrade(
              game, thisPlayerNr, <TichuCard>[...cards.whereType<TichuCard>()]);
          if (sr.err != null) {
            showPlatformAlertDialog(
              title: 'An error occurred',
              contentText: sr.err.toString(),
            );
            return;
          }
          thisPlayerHasTraded.value = true;
        },
      ),
    );
  }
}
