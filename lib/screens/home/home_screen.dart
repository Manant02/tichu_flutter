import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tichu_flutter/models/tichu_table.dart';
import 'package:tichu_flutter/screens/new_table/new_table_screen.dart';
import 'package:tichu_flutter/services/firestore.dart';
import 'package:tichu_flutter/widgets/my_list_tile.dart';
import 'package:velocity_x/velocity_x.dart';

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
              flex: 1,
              child:
                  Image.asset('images/tichu-logo-transparent.png', width: 250),
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  36.heightBox,
                  const Text(
                    'Open Tables',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  16.heightBox,
                  StreamBuilder(
                    stream: Firestore().getTichuTableStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("Loading");
                      }
                      return ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                              final table =
                                  TichuTable.fromDocumentSnapshot(document);
                              return OpenTableTile(
                                table: table,
                              );
                            })
                            .toList()
                            .cast(),
                      ).px(30).expand();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
