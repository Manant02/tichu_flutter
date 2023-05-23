import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tichu_flutter/models/enums.dart';
import 'package:tichu_flutter/widgets/press_start.dart';
import 'package:tichu_flutter/widgets/ready_or_cancel.dart';
import 'package:tichu_flutter/widgets/waiting_for_players.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/service_response.dart';
import '../../models/tichu_table.dart';
import '../../models/tichu_user.dart';
import '../../widgets/player_banner.dart';

class PreGameView extends StatelessWidget {
  const PreGameView({
    super.key,
    required this.table,
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

  final PlayerNr thisPlayerNr;
  final Future<ServiceResponse<TichuUser?>> teamMateSRFuture;
  final PlayerNr teamMateNr;
  final Future<ServiceResponse<TichuUser?>> oppRightSRFuture;
  final PlayerNr oppRightNr;
  final Future<ServiceResponse<TichuUser?>> oppLeftSRFuture;
  final PlayerNr oppLeftNr;

  @override
  Widget build(BuildContext context) {
    final bool tableFull = table.player1Uid.isNotEmptyAndNotNull &&
        table.player2Uid.isNotEmptyAndNotNull &&
        table.player3Uid.isNotEmptyAndNotNull &&
        table.player4Uid.isNotEmptyAndNotNull;

    final bool thisPlayerReady = thisPlayerNr == PlayerNr.one
        ? table.player1Ready
        : thisPlayerNr == PlayerNr.two
            ? table.player2Ready
            : thisPlayerNr == PlayerNr.three
                ? table.player3Ready
                : thisPlayerNr == PlayerNr.four
                    ? table.player4Ready
                    : true;

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
          null,
        ),
        buildPlayerBannerFromSRFuture(
          oppRightSRFuture,
          oppRightNr,
          TablePos.OppRight,
          table,
          null,
        ),
        buildPlayerBannerFromSRFuture(
          oppLeftSRFuture,
          oppLeftNr,
          TablePos.OppLeft,
          table,
          null,
        ),
        if (!tableFull) const WaitingForPlayers(),
        if (tableFull && !thisPlayerReady)
          PressStart(table: table, thisPlayerNr: thisPlayerNr),
        if (thisPlayerReady && table.gameUid == null)
          ReadyOrCancel(table: table, thisPlayerNr: thisPlayerNr),
        if (table.gameUid != null)
          Align(
            alignment: const Alignment(0, 0),
            child: Text(
              'GAME\n${table.gameUid!}',
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}
