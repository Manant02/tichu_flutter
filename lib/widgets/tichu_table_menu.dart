import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tichu_flutter/services/firestore.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/enums.dart';
import '../models/tichu_table.dart';
import '../models/tichu_user.dart';
import '../screens/home/home_screen.dart';
import '../utils/show_platform_alert_dialog.dart';
import 'my_primary_button.dart';

class TichuTableMenu extends StatelessWidget {
  const TichuTableMenu({
    super.key,
    required this.tichuUser,
    required this.tichuTable,
  });

  final TichuUser tichuUser;
  final TichuTable tichuTable;

  @override
  Widget build(BuildContext context) {
    final firestore = Firestore();
    return Container(
      // width: 0.8.sw(context),
      // height: 300,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          MyPrimaryButton(
            text: 'Fill empty spots',
            onPressed: () {
              firestore.addPlayerToTable(
                  '0XmPr9xUynha20jmwlYL514ha2Z2', tichuTable);
              firestore.addPlayerToTable(
                  'NZNkdjoM6FRb76U3jD31xd8xRTp2', tichuTable);
              firestore.addPlayerToTable(
                  'q4a9TpE3HfUPZmCj7PWFv9FHP4n1', tichuTable);
              firestore.addPlayerToTable(
                  'tTKQdIh8ohMz4Lqosm8RpeKnl4p2', tichuTable);
            },
          ).p(8),
          MyPrimaryButton(
            text: 'Ready up',
            onPressed: () {
              firestore.setPlayerReady(tichuTable, PlayerNr.one);
              firestore.setPlayerReady(tichuTable, PlayerNr.two);
              firestore.setPlayerReady(tichuTable, PlayerNr.three);
              firestore.setPlayerReady(tichuTable, PlayerNr.four);
            },
          ).p(8),
          MyPrimaryButton(
            text: 'Leave table',
            onPressed: () {
              showPlatformAlertDialog(
                title: 'Leave table?',
                contentText:
                    'Are you sure you want to leave this table? Any ongoing game will be stopped and lost.',
                button2Text: 'Leave',
                button2OnPressed: () async {
                  final res = await firestore.removePlayerFromTable(
                    tichuUser.uid,
                    tichuTable,
                  );
                  print(res.err);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                      (route) => false);
                },
                button1Text: 'Cancel',
                button1OnPressed: () => Navigator.of(context).pop(),
              );
            },
          ).py(8),
          MyPrimaryButton(
            text: 'Back to game',
            onPressed: () => Navigator.of(context).pop(),
          ).py(8),
        ],
      ),
    );
  }
}
