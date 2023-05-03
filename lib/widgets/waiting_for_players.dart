import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class WaitingForPlayers extends StatelessWidget {
  const WaitingForPlayers({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment(0, 0),
      child: Text(
        'waiting for others...',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
      ),
    );
  }
}
