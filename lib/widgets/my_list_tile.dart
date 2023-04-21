import 'package:flutter/material.dart';
import 'package:tichu_flutter/screens/tichu_table/tichu_table_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/tichu_table.dart';

class OpenTableTile extends StatelessWidget {
  const OpenTableTile({
    Key? key,
    required this.table,
  }) : super(key: key);

  final TichuTable table;

  @override
  Widget build(BuildContext context) {
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
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
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
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TichuTableScreen(tableUid: table.uid),
            ),
          ),
        ),
      ).p8(),
    );
  }
}
