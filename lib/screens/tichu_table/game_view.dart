import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tichu_flutter/models/tichu_card.dart';
import 'package:tichu_flutter/models/tichu_game.dart';
import 'package:tichu_flutter/widgets/my_hand.dart';
import 'package:tichu_flutter/widgets/other_hand.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tichu_flutter/widgets/trade_button.dart';
import 'package:tichu_flutter/widgets/trading_fields.dart';
import 'package:tichu_flutter/widgets/waiting_for_everyone_to_trade.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/enums.dart';
import '../../models/service_response.dart';
import '../../models/tichu_table.dart';
import '../../models/tichu_user.dart';
import '../../widgets/player_banner.dart';
import '../../utils/extensions.dart';

class GameView extends HookWidget {
  const GameView({
    super.key,
    required this.table,
    required this.game,
    required this.thisPlayer,
    required this.thisPlayerNr,
    required this.teamMateSRFuture,
    required this.teamMateNr,
    required this.oppRightSRFuture,
    required this.oppRightNr,
    required this.oppLeftSRFuture,
    required this.oppLeftNr,
  });

  final TichuTable table;
  final TichuUser thisPlayer;
  final TichuGame game;

  final PlayerNr thisPlayerNr;
  final Future<ServiceResponse<TichuUser?>> teamMateSRFuture;
  final PlayerNr teamMateNr;
  final Future<ServiceResponse<TichuUser?>> oppRightSRFuture;
  final PlayerNr oppRightNr;
  final Future<ServiceResponse<TichuUser?>> oppLeftSRFuture;
  final PlayerNr oppLeftNr;

  @override
  Widget build(BuildContext context) {
    final thisPlayerHand = thisPlayerNr == PlayerNr.one
        ? game.player1Hand
        : thisPlayerNr == PlayerNr.two
            ? game.player2Hand
            : thisPlayerNr == PlayerNr.three
                ? game.player3Hand
                : thisPlayerNr == PlayerNr.four
                    ? game.player4Hand
                    : null;

    late final List<TichuCard>? teamMateHand;
    late final List<TichuCard>? oppRightHand;
    late final List<TichuCard>? oppLeftHand;

    if (thisPlayerNr == PlayerNr.one) {
      teamMateHand = game.player3Hand;
      oppRightHand = game.player2Hand;
      oppLeftHand = game.player4Hand;
    }
    if (thisPlayerNr == PlayerNr.two) {
      teamMateHand = game.player4Hand;
      oppRightHand = game.player3Hand;
      oppLeftHand = game.player1Hand;
    }
    if (thisPlayerNr == PlayerNr.three) {
      teamMateHand = game.player1Hand;
      oppRightHand = game.player4Hand;
      oppLeftHand = game.player2Hand;
    }
    if (thisPlayerNr == PlayerNr.four) {
      teamMateHand = game.player2Hand;
      oppRightHand = game.player1Hand;
      oppLeftHand = game.player3Hand;
    }

    final tradingCards =
        useState(List<TichuCard?>.generate(3, (idx) => null, growable: true));
    final thisPlayerHasTraded = useState(false);

    final thisPlayerHandFiltered = thisPlayerHand?.toList();
    thisPlayerHandFiltered
        ?.removeWhere((element) => tradingCards.value.contains(element));

    final selectedCards = useState(List<bool>.generate(
      thisPlayerHand?.length ?? 0,
      (idx) => false,
    ));

    if (thisPlayerHandFiltered?.length != selectedCards.value.length) {
      selectedCards.value = List<bool>.generate(
        thisPlayerHandFiltered?.length ?? 0,
        (idx) => false,
      );
    }

    return Stack(
      children: [
        PlayerBanner(
          table: table,
          tichuUser: thisPlayer,
          playerNr: thisPlayerNr,
          tablePos: TablePos.thisPlayer,
          state: game.turn == thisPlayerNr
              ? BannerState.turn
              : BannerState.neutral,
          tichu: false,
          grandTichu: false,
        ),
        buildPlayerBannerFromSRFuture(
          teamMateSRFuture,
          teamMateNr,
          TablePos.teamMate,
          table,
          game.turn,
        ),
        buildPlayerBannerFromSRFuture(
          oppRightSRFuture,
          oppRightNr,
          TablePos.OppRight,
          table,
          game.turn,
        ),
        buildPlayerBannerFromSRFuture(
          oppLeftSRFuture,
          oppLeftNr,
          TablePos.OppLeft,
          table,
          game.turn,
        ),
        if (thisPlayerHand != null && thisPlayerHandFiltered != null)
          MyHand(
            hand: thisPlayerHandFiltered,
            selectedCards: selectedCards,
            selectMaxOne: game.trading,
          ),
        if (teamMateHand != null)
          OtherHand(
            hand: teamMateHand,
            tablePos: TablePos.teamMate,
          ),
        if (oppRightHand != null)
          OtherHand(
            hand: oppRightHand,
            tablePos: TablePos.OppRight,
          ),
        if (oppLeftHand != null)
          OtherHand(
            hand: oppLeftHand,
            tablePos: TablePos.OppLeft,
          ),
        if (game.trading && !thisPlayerHasTraded.value)
          TradingFields(
            tradingCards: tradingCards,
            selectedCards: selectedCards,
            thisPlayerHandFiltered: thisPlayerHandFiltered,
          ),
        if (game.trading && !thisPlayerHasTraded.value)
          TradeButton(
            game: game,
            thisPlayerNr: thisPlayerNr,
            tradingCards: tradingCards,
            thisPlayerHasTraded: thisPlayerHasTraded,
          ),
        if (game.trading && thisPlayerHasTraded.value)
          const WaitingForEveryoneToTrade(),
        // Align(
        //   alignment: Alignment(0.5, 0.5),
        //   child: Text(
        //       'selectedCards.length: ${selectedCards.value.length}\nthisPlayerHand.length: ${thisPlayerHand?.length}\nthisPlayerHandFiltered.length: ${thisPlayerHandFiltered?.length}'),
        // ),
      ],
    );
  }
}
