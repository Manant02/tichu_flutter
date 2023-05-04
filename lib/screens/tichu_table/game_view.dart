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
    final thisPlayerHand =
        useState<List<TichuCard>?>(thisPlayerNr == PlayerNr.one
            ? game.player1Hand
            : thisPlayerNr == PlayerNr.two
                ? game.player2Hand
                : thisPlayerNr == PlayerNr.three
                    ? game.player3Hand
                    : thisPlayerNr == PlayerNr.four
                        ? game.player4Hand
                        : null);

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

    final selectedCards = useState(List<bool>.generate(
      thisPlayerHand.value?.length ?? 0,
      (idx) => false,
    ));
    thisPlayerHand.addListener(() {
      selectedCards.value = List<bool>.generate(
        thisPlayerHand.value?.length ?? 0,
        (idx) => false,
      );
    });

    final tradingCards =
        useState(List<TichuCard?>.generate(3, (idx) => null, growable: false));

    return Stack(
      children: [
        PlayerBanner(
          table: table,
          tichuUser: thisPlayer,
          playerNr: thisPlayerNr,
          tablePos: TablePos.thisPlayer,
          state: BannerState.neutral,
          tichu: false,
          grandTichu: false,
        ),
        buildPlayerBannerFromSRFuture(
          teamMateSRFuture,
          teamMateNr,
          TablePos.teamMate,
          table,
        ),
        buildPlayerBannerFromSRFuture(
          oppRightSRFuture,
          oppRightNr,
          TablePos.OppRight,
          table,
        ),
        buildPlayerBannerFromSRFuture(
          oppLeftSRFuture,
          oppLeftNr,
          TablePos.OppLeft,
          table,
        ),
        if (thisPlayerHand != null)
          MyHand(
            hand: thisPlayerHand.value!,
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
        if (game.trading)
          TradingFields(
            tradingCards: tradingCards,
            selectedCards: selectedCards,
            thisPlayerHand: thisPlayerHand,
          ),
        if (game.trading)
          TradeButton(
              game: game, thisPlayerNr: thisPlayerNr, cards: tradingCards.value)
      ],
    );
  }
}
