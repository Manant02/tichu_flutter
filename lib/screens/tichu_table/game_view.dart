import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tichu_flutter/models/tichu_game.dart';
import 'package:tichu_flutter/widgets/my_hand.dart';
import 'package:tichu_flutter/widgets/other_hand.dart';

import '../../models/enums.dart';
import '../../models/service_response.dart';
import '../../models/tichu_table.dart';
import '../../models/tichu_user.dart';
import '../../widgets/player_banner.dart';

class GameView extends StatelessWidget {
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
  final TichuGame game;
  final TichuUser thisPlayer;
  final PlayerNr thisPlayerNr;
  final Future<ServiceResponse<TichuUser?>> teamMateSRFuture;
  final PlayerNr teamMateNr;
  final Future<ServiceResponse<TichuUser?>> oppRightSRFuture;
  final PlayerNr oppRightNr;
  final Future<ServiceResponse<TichuUser?>> oppLeftSRFuture;
  final PlayerNr oppLeftNr;

  @override
  Widget build(BuildContext context) {
    late final List<String>? thisPlayerHand;
    late final List<String>? teamMateHand;
    late final List<String>? oppRightHand;
    late final List<String>? oppLeftHand;

    if (thisPlayerNr == PlayerNr.one) {
      thisPlayerHand = game.player1Hand;
      teamMateHand = game.player3Hand;
      oppRightHand = game.player2Hand;
      oppLeftHand = game.player4Hand;
    }
    if (thisPlayerNr == PlayerNr.two) {
      thisPlayerHand = game.player2Hand;
      teamMateHand = game.player4Hand;
      oppRightHand = game.player3Hand;
      oppLeftHand = game.player1Hand;
    }
    if (thisPlayerNr == PlayerNr.three) {
      thisPlayerHand = game.player3Hand;
      teamMateHand = game.player1Hand;
      oppRightHand = game.player4Hand;
      oppLeftHand = game.player2Hand;
    }
    if (thisPlayerNr == PlayerNr.four) {
      thisPlayerHand = game.player4Hand;
      teamMateHand = game.player2Hand;
      oppRightHand = game.player1Hand;
      oppLeftHand = game.player3Hand;
    }
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
        if (thisPlayerHand != null) MyHand(hand: thisPlayerHand),
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
      ],
    );
  }
}
