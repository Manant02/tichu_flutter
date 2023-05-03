import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tichu_flutter/models/tichu_table.dart';
import 'package:tichu_flutter/screens/new_table/new_table_screen.dart';
import 'package:tichu_flutter/screens/signup/signup_form.dart';
import 'package:tichu_flutter/services/firestore.dart';
import 'package:tichu_flutter/services/functions.dart';
import 'package:tichu_flutter/utils/extensions.dart';
import 'package:tichu_flutter/utils/show_platform_alert_dialog.dart';
import 'package:tichu_flutter/widgets/my_list_tile.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widgets/loading_overlay.dart';
import '../../widgets/my_back_button.dart';
import '../../widgets/my_primary_button.dart';

final signupLoadingProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

class SignupScreen extends ConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: LoadingOverlay(
          isLoading: ref.watch(signupLoadingProvider),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: 1.sh(context) > 400 ? 1.sh(context) : 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      const MyBackButton().p(10),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: const Text(
                    'New Account',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                    ),
                  ).centered(),
                ),
                const Expanded(
                  flex: 10,
                  child: SignupForm(),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                )
              ],
            ),
          ).scrollVertical(),
        ),
      ),
    );
  }
}
