import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tichu_flutter/screens/new_table/new_table_screen.dart';

import '../../widgets/my_primary_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(),
            Expanded(
              flex: 3,
              child:
                  Image.asset('images/tichu-logo-transparent.png', width: 250),
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyPrimaryButton(
                    width: 200,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const NewTableScreen(),
                        ),
                      );
                    },
                    text: 'New Table',
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
