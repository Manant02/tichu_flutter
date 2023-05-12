import 'package:flutter/material.dart';
import 'package:tichu_flutter/utils/extensions.dart';
import 'package:velocity_x/velocity_x.dart';

class WaitingForEveryoneToTrade extends StatelessWidget {
  const WaitingForEveryoneToTrade({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 0),
      child: const Text(
        'Waiting for everyone to complete their trade',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ).w(0.8.sw(context)),
    );
  }
}
