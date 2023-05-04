import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tichu_flutter/models/enums.dart';
import 'package:tichu_flutter/models/tichu_table.dart';
import 'package:tichu_flutter/services/firestore.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/service_response.dart';
import '../models/tichu_user.dart';

FutureBuilder<ServiceResponse<TichuUser?>> buildPlayerBannerFromSRFuture(
  Future<ServiceResponse<TichuUser?>> playerSRFuture,
  PlayerNr playerNr,
  TablePos bannerPos,
  TichuTable table,
) {
  return FutureBuilder(
    future: playerSRFuture,
    builder: (
      BuildContext context,
      AsyncSnapshot<ServiceResponse<TichuUser?>> snapshot,
    ) {
      if (snapshot.hasData) {
        final res = snapshot.data!;
        if (res.err == null) {
          return PlayerBanner(
            tichuUser: res.ret,
            playerNr: playerNr,
            tablePos: bannerPos,
            table: table,
            state: res.ret == null ? BannerState.empty : BannerState.neutral,
            tichu: false,
            grandTichu: false,
          );
        } else {
          return Text('Error: ${res.err}');
        }
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error.toString()}');
      } else {
        return Container(); //TODO: PlayerBanner loading widget
      }
    },
  );
}

class PlayerBanner extends StatelessWidget {
  const PlayerBanner({
    super.key,
    required this.table,
    required this.tichuUser,
    required this.playerNr,
    required this.tablePos,
    required this.state,
    required this.tichu,
    required this.grandTichu,
  });

  final TichuTable table;
  final TichuUser? tichuUser;
  final PlayerNr playerNr;
  final TablePos tablePos;
  final BannerState state;
  final bool tichu;
  final bool grandTichu;

  @override
  Widget build(BuildContext context) {
    final firestore = Firestore();

    // TODO: assert that banner state makes sense
    //       (e.g. not have [TablePos.thisPlayer] and [BannerState.empty])

    return Align(
      alignment: tablePos == TablePos.thisPlayer
          ? const Alignment(0, 0.55)
          : tablePos == TablePos.teamMate
              ? const Alignment(0, -1)
              : tablePos == TablePos.OppRight
                  ? const Alignment(0.9, -0.6)
                  : tablePos == TablePos.OppLeft
                      ? const Alignment(-0.9, -0.6)
                      : const Alignment(0, 0),
      child: InkWell(
        onTap: () {
          switch (state) {
            case BannerState.empty:
              late PlayerNr otherPlayerNr;
              switch (tablePos) {
                case TablePos.teamMate:
                  if (playerNr == PlayerNr.one) otherPlayerNr = PlayerNr.three;
                  if (playerNr == PlayerNr.two) otherPlayerNr = PlayerNr.four;
                  if (playerNr == PlayerNr.three) otherPlayerNr = PlayerNr.one;
                  if (playerNr == PlayerNr.four) otherPlayerNr = PlayerNr.two;
                  break;
                case TablePos.OppRight:
                  if (playerNr == PlayerNr.one) otherPlayerNr = PlayerNr.four;
                  if (playerNr == PlayerNr.two) otherPlayerNr = PlayerNr.one;
                  if (playerNr == PlayerNr.three) otherPlayerNr = PlayerNr.two;
                  if (playerNr == PlayerNr.four) otherPlayerNr = PlayerNr.three;
                  break;
                case TablePos.OppLeft:
                  if (playerNr == PlayerNr.one) otherPlayerNr = PlayerNr.two;
                  if (playerNr == PlayerNr.two) otherPlayerNr = PlayerNr.three;
                  if (playerNr == PlayerNr.three) otherPlayerNr = PlayerNr.four;
                  if (playerNr == PlayerNr.four) otherPlayerNr = PlayerNr.one;
                  break;
                default:
                  return;
              }
              firestore.swapTableSpots(table, playerNr, otherPlayerNr);
              break;
            case BannerState.dragon:
              // TODO: give dragon
              break;
            default:
              return;
          }
        },
        child: Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: state == BannerState.empty
                ? Colors.white
                : state == BannerState.neutral
                    ? Colors.lime
                    : state == BannerState.turn
                        ? Colors.greenAccent
                        : state == BannerState.pass
                            ? Colors.redAccent
                            : state == BannerState.dragon
                                ? Colors.blueAccent
                                : Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tichuUser?.username ?? 'Empty',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (state == BannerState.empty)
                const Text(
                  'Tap to sit here',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              if (tichu)
                const Text(
                  'Tichu',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
              if (grandTichu)
                const Text(
                  'Grand Tichu',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
