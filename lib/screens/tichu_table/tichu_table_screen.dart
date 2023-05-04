import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tichu_flutter/models/enums.dart';
import 'package:tichu_flutter/models/tichu_game.dart';
import 'package:tichu_flutter/screens/home/home_screen.dart';
import 'package:tichu_flutter/screens/tichu_table/game_view.dart';
import 'package:tichu_flutter/screens/tichu_table/pre_game_view.dart';
import 'package:tichu_flutter/services/auth.dart';
import 'package:tichu_flutter/services/firestore.dart';
import 'package:tichu_flutter/services/providers.dart';
import 'package:tichu_flutter/utils/extensions.dart';
import 'package:tichu_flutter/utils/show_platform_alert_dialog.dart';
import 'package:tichu_flutter/widgets/loading_overlay.dart';
import 'package:tichu_flutter/widgets/my_primary_button.dart';
import 'package:tichu_flutter/widgets/tichu_card_widget.dart';
import 'package:tichu_flutter/widgets/tichu_table_menu.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/service_response.dart';
import '../../models/tichu_table.dart';
import '../../models/tichu_user.dart';
import '../../widgets/player_banner.dart';

class TichuTableScreen extends ConsumerWidget {
  const TichuTableScreen({
    super.key,
    required this.tableUid,
  });

  final String tableUid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tichuTableStream = ref.watch(tichuTableStreamProvider(tableUid));
    final tichuUserStream = ref.watch(tichuUserStreamProvider);
    final firestore = Firestore();

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.green,
        // appBar: AppBar(title: ,),
        body: SafeArea(
          child: tichuUserStream.when(
            loading: () => const LoadingOverlay(isLoading: true),
            error: (error, stackTrace) {
              showPlatformAlertDialog(
                title: 'An error occurred',
                contentText: error.toString(),
                button1OnPressed: () =>
                    Auth().navigateBasedOnAuthState(Navigator.of(context)),
              );
              return Text('Error: ${error.toString()}').centered();
            },
            data: (thisPlayer) {
              if (thisPlayer == null) {
                showPlatformAlertDialog(
                  title: 'User not found',
                  contentText: 'Current user could not be resolved.',
                  button1OnPressed: () =>
                      Auth().navigateBasedOnAuthState(Navigator.of(context)),
                );
                return const Text('Error: Current user could not be resolved.')
                    .centered();
              }
              return tichuTableStream.when(
                loading: () => const LoadingOverlay(isLoading: true),
                error: (error, stackTrace) {
                  showPlatformAlertDialog(
                    title: 'An error occurred',
                    contentText: error.toString(),
                    button1OnPressed: () =>
                        Auth().navigateBasedOnAuthState(Navigator.of(context)),
                  );
                  return Text('Error: ${error.toString()}').centered();
                },
                data: (tichuTable) {
                  if (tichuTable == null) {
                    showPlatformAlertDialog(
                      title: 'Table not found',
                      contentText: 'Could not find a table with UID $tableUid.',
                      button1OnPressed: () => Auth()
                          .navigateBasedOnAuthState(Navigator.of(context)),
                    );
                    return Text(
                            'Error: Could not find a table with UID $tableUid.')
                        .centered();
                  }

                  late final PlayerNr thisPlayerNr;

                  late final PlayerNr teamMateNr;
                  late final Future<ServiceResponse<TichuUser?>>
                      teamMateSRFuture;

                  late final PlayerNr oppRightNr;
                  late final Future<ServiceResponse<TichuUser?>>
                      oppRightSRFuture;

                  late final PlayerNr oppLeftNr;
                  late final Future<ServiceResponse<TichuUser?>>
                      oppLeftSRFuture;

                  if (tichuTable.player1Uid == thisPlayer.uid) {
                    thisPlayerNr = PlayerNr.one;
                    teamMateNr = PlayerNr.three;
                    oppRightNr = PlayerNr.two;
                    oppLeftNr = PlayerNr.four;

                    if (tichuTable.player3Uid != null) {
                      teamMateSRFuture =
                          firestore.getTichuUserByUid(tichuTable.player3Uid!);
                    } else {
                      teamMateSRFuture =
                          Future(() => ServiceResponse(null, null));
                    }
                    if (tichuTable.player2Uid != null) {
                      oppRightSRFuture =
                          firestore.getTichuUserByUid(tichuTable.player2Uid!);
                    } else {
                      oppRightSRFuture =
                          Future(() => ServiceResponse(null, null));
                    }
                    if (tichuTable.player4Uid != null) {
                      oppLeftSRFuture =
                          firestore.getTichuUserByUid(tichuTable.player4Uid!);
                    } else {
                      oppLeftSRFuture =
                          Future(() => ServiceResponse(null, null));
                    }
                  } else if (tichuTable.player2Uid == thisPlayer.uid) {
                    thisPlayerNr = PlayerNr.two;
                    teamMateNr = PlayerNr.four;
                    oppRightNr = PlayerNr.three;
                    oppLeftNr = PlayerNr.one;
                    if (tichuTable.player4Uid != null) {
                      teamMateSRFuture =
                          firestore.getTichuUserByUid(tichuTable.player4Uid!);
                    } else {
                      teamMateSRFuture =
                          Future(() => ServiceResponse(null, null));
                    }
                    if (tichuTable.player3Uid != null) {
                      oppRightSRFuture =
                          firestore.getTichuUserByUid(tichuTable.player3Uid!);
                    } else {
                      oppRightSRFuture =
                          Future(() => ServiceResponse(null, null));
                    }
                    if (tichuTable.player1Uid != null) {
                      oppLeftSRFuture =
                          firestore.getTichuUserByUid(tichuTable.player1Uid!);
                    } else {
                      oppLeftSRFuture =
                          Future(() => ServiceResponse(null, null));
                    }
                  } else if (tichuTable.player3Uid == thisPlayer.uid) {
                    thisPlayerNr = PlayerNr.three;
                    teamMateNr = PlayerNr.one;
                    oppRightNr = PlayerNr.four;
                    oppLeftNr = PlayerNr.two;
                    if (tichuTable.player1Uid != null) {
                      teamMateSRFuture =
                          firestore.getTichuUserByUid(tichuTable.player1Uid!);
                    } else {
                      teamMateSRFuture =
                          Future(() => ServiceResponse(null, null));
                    }
                    if (tichuTable.player4Uid != null) {
                      oppRightSRFuture =
                          firestore.getTichuUserByUid(tichuTable.player4Uid!);
                    } else {
                      oppRightSRFuture =
                          Future(() => ServiceResponse(null, null));
                    }
                    if (tichuTable.player2Uid != null) {
                      oppLeftSRFuture =
                          firestore.getTichuUserByUid(tichuTable.player2Uid!);
                    } else {
                      oppLeftSRFuture =
                          Future(() => ServiceResponse(null, null));
                    }
                  } else if (tichuTable.player4Uid == thisPlayer.uid) {
                    thisPlayerNr = PlayerNr.four;
                    teamMateNr = PlayerNr.two;
                    oppRightNr = PlayerNr.one;
                    oppLeftNr = PlayerNr.three;
                    if (tichuTable.player2Uid != null) {
                      teamMateSRFuture =
                          firestore.getTichuUserByUid(tichuTable.player2Uid!);
                    } else {
                      teamMateSRFuture =
                          Future(() => ServiceResponse(null, null));
                    }
                    if (tichuTable.player1Uid != null) {
                      oppRightSRFuture =
                          firestore.getTichuUserByUid(tichuTable.player1Uid!);
                    } else {
                      oppRightSRFuture =
                          Future(() => ServiceResponse(null, null));
                    }
                    if (tichuTable.player3Uid != null) {
                      oppLeftSRFuture =
                          firestore.getTichuUserByUid(tichuTable.player3Uid!);
                    } else {
                      oppLeftSRFuture =
                          Future(() => ServiceResponse(null, null));
                    }
                  } else {
                    return Text('Error: User not a player on this table.')
                        .centered();
                  }

                  AsyncValue<TichuGame>? tichuGameStream;

                  if (tichuTable.gameUid != null) {
                    tichuGameStream =
                        ref.watch(tichuGameStreamProvider(tichuTable.gameUid!));
                  }

                  return Column(
                    children: [
                      Row(
                        children: [
                          10.widthBox,
                          Text(
                            tichuTable.name,
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w600,
                            ),
                          ).expand(),
                          IconButton(
                            icon: const Icon(Icons.apps),
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) => Stack(
                                children: [
                                  const ModalBarrier(
                                    dismissible: true,
                                  ),
                                  TichuTableMenu(
                                    tichuUser: thisPlayer,
                                    tichuTable: tichuTable,
                                  ).centered(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ).p(6),
                      if (tichuGameStream == null)
                        PreGameView(
                          table: tichuTable,
                          thisPlayer: thisPlayer,
                          thisPlayerNr: thisPlayerNr,
                          teamMateSRFuture: teamMateSRFuture,
                          teamMateNr: teamMateNr,
                          oppRightSRFuture: oppRightSRFuture,
                          oppRightNr: oppRightNr,
                          oppLeftSRFuture: oppLeftSRFuture,
                          oppLeftNr: oppLeftNr,
                        ).expand(),
                      if (tichuGameStream != null)
                        tichuGameStream.when(
                          loading: () => const LoadingOverlay(
                              isLoading: true, showModalBarrier: false),
                          error: (error, stackTrace) {
                            showPlatformAlertDialog(
                              title: 'An error occurred',
                              contentText: error.toString(),
                              button1OnPressed: () => Auth()
                                  .navigateBasedOnAuthState(
                                      Navigator.of(context)),
                            );
                            return Text('Error: ${error.toString()}')
                                .centered();
                          },
                          data: (tichuGame) {
                            return GameView(
                              table: tichuTable,
                              game: tichuGame,
                              thisPlayer: thisPlayer,
                              thisPlayerNr: thisPlayerNr,
                              teamMateSRFuture: teamMateSRFuture,
                              teamMateNr: teamMateNr,
                              oppRightSRFuture: oppRightSRFuture,
                              oppRightNr: oppRightNr,
                              oppLeftSRFuture: oppLeftSRFuture,
                              oppLeftNr: oppLeftNr,
                            ).expand();
                          },
                        ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
