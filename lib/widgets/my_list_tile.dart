import 'package:flutter/material.dart';
import 'package:tichu_flutter/screens/tichu_table/tichu_table_screen.dart';
import 'package:tichu_flutter/services/firestore.dart';
import 'package:tichu_flutter/utils/show_platform_alert_dialog.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/tichu_table.dart';
import '../models/tichu_user.dart';

class OpenTableTile extends StatelessWidget {
  const OpenTableTile({
    Key? key,
    required this.table,
    required this.tichuUser,
  }) : super(key: key);

  final TichuTable table;
  final TichuUser tichuUser;

  @override
  Widget build(BuildContext context) {
    final firestore = Firestore();
    return Material(
      color: Colors.transparent,
      child: ListTile(
        title: Text(
          table.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        tileColor: Colors.yellow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        trailing: InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(90),
                border: Border.all(width: 1.6),
              ),
              child: const Text(
                'Join',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            onTap: () => showPlatformAlertDialog(
                  title: 'Join ${table.name}?',
                  contentText: 'Are you sure you want to join this table?',
                  button2Text: 'Join',
                  button2OnPressed: () async {
                    final navigator = Navigator.of(context);
                    final res = await firestore.addPlayerToTable(
                      tichuUser.uid,
                      table,
                    );
                    if (res.err == null ||
                        res.err ==
                            'Firestore.createUserDoc:PlayerAlreadyAtTable') {
                      navigator.pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => TichuTableScreen(
                              tableUid: table.uid,
                            ),
                          ),
                          (route) => false);
                    } else if (res.err == 'Firestore.createUserDoc:TableFull') {
                      navigator.pop();
                      showPlatformAlertDialog(
                        title: 'Table full',
                        contentText: 'This table already has 4 players.',
                        button1OnPressed: () => navigator.pop(),
                      );
                    } else {
                      navigator.pop();
                      showPlatformAlertDialog(
                        title: 'An error occurred',
                        contentText: res.err.toString(),
                        button1OnPressed: () => navigator.pop(),
                      );
                    }
                  },
                  button1Text: 'Cancel',
                  button1OnPressed: () => Navigator.of(context).pop(),
                )),
      ).p8(),
    );
  }
}
