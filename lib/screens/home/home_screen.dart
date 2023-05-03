import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tichu_flutter/models/tichu_table.dart';
import 'package:tichu_flutter/screens/login/login_screen.dart';
import 'package:tichu_flutter/screens/new_table/new_table_screen.dart';
import 'package:tichu_flutter/services/auth.dart';
import 'package:tichu_flutter/services/firestore.dart';
import 'package:tichu_flutter/services/functions.dart';
import 'package:tichu_flutter/utils/show_platform_alert_dialog.dart';
import 'package:tichu_flutter/widgets/loading_overlay.dart';
import 'package:tichu_flutter/widgets/my_list_tile.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../services/providers.dart';
import '../../widgets/my_primary_button.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUserStream = ref.watch(authUserStreamProvider);
    final tichuUserStream = ref.watch(tichuUserStreamProvider);

    return Scaffold(
      body: SafeArea(
        child: tichuUserStream.when(
            loading: () => LoadingOverlay(isLoading: true),
            error: (error, stackTrace) =>
                Text('Error: ${error.toString()}').centered(),
            data: (tichuUser) {
              if (tichuUser == null) {
                return const Text('Error: Current user could not be resolved')
                    .centered();
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(),
                  Expanded(
                    flex: 1,
                    child: Image.asset('images/tichu-logo-transparent.png',
                        width: 250),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Text(
                        //   authUserStream.when(
                        //     loading: () => 'Loading',
                        //     error: (error, stackTrace) => error.toString(),
                        //     data: (authUser) =>
                        //         'AUTH:\n${authUser?.displayName}\n${authUser?.uid}',
                        //   ),
                        //   textAlign: TextAlign.center,
                        // ),
                        Text(
                          tichuUserStream.when(
                            loading: () => 'Loading',
                            error: (error, stackTrace) => error.toString(),
                            data: (tichuUser) =>
                                'TICHU USER:\n${tichuUser?.username}\n${tichuUser?.uid}',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        MyPrimaryButton(
                          text: 'Debug',
                          onPressed: () {
                            Auth().logout(Navigator.of(context));
                          },
                        ),
                        16.heightBox,
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
                          stream: Firestore().getTichuTablesStream(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text("Loading");
                            }
                            return ListView(
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                    final table =
                                        TichuTable.fromDocumentSnapshot(
                                            document);
                                    return OpenTableTile(
                                      table: table,
                                      tichuUser: tichuUser,
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
              );
            }),
      ),
    );
  }
}
