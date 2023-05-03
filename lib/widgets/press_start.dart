import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tichu_flutter/models/enums.dart';
import 'package:tichu_flutter/models/tichu_table.dart';
import 'package:tichu_flutter/services/firestore.dart';

import 'my_primary_button.dart';

class PressStart extends StatelessWidget {
  const PressStart({
    super.key,
    required this.table,
    required this.thisPlayerNr,
  });

  final TichuTable table;
  final PlayerNr thisPlayerNr;

  @override
  Widget build(BuildContext context) {
    final firestore = Firestore();
    return Align(
      alignment: const Alignment(0, 0),
      child: MyPrimaryButton(
        text: 'Start',
        onPressed: () {
          firestore.setPlayerReady(table, thisPlayerNr);
        },
      ),
    );
  }
}
