import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:velocity_x/velocity_x.dart';

class TichuTableScreen extends StatelessWidget {
  const TichuTableScreen({
    super.key,
    required this.tableUid,
  });

  final String tableUid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text(tableUid).centered(),
      ),
    );
  }
}
