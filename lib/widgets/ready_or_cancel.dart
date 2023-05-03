import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tichu_flutter/models/tichu_table.dart';
import 'package:tichu_flutter/services/firestore.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/enums.dart';

class ReadyOrCancel extends StatelessWidget {
  const ReadyOrCancel({
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
      alignment: Alignment(0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            ' Ready!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          12.heightBox,
          InkWell(
            onTap: () {
              firestore.setPlayerNotReady(table, thisPlayerNr);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(90),
                border: Border.all(width: 1.6),
              ),
              child: const Text(
                'cancel',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
