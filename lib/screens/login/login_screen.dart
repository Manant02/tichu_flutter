import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tichu_flutter/models/tichu_table.dart';
import 'package:tichu_flutter/screens/login/login_form.dart';
import 'package:tichu_flutter/screens/new_table/new_table_screen.dart';
import 'package:tichu_flutter/screens/signup/signup_screen.dart';
import 'package:tichu_flutter/services/firestore.dart';
import 'package:tichu_flutter/services/functions.dart';
import 'package:tichu_flutter/utils/extensions.dart';
import 'package:tichu_flutter/utils/show_platform_alert_dialog.dart';
import 'package:tichu_flutter/widgets/loading_overlay.dart';
import 'package:tichu_flutter/widgets/my_list_tile.dart';
import 'package:tichu_flutter/widgets/my_textfield.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widgets/my_primary_button.dart';

final loginLoadingProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: LoadingOverlay(
          isLoading: ref.watch(loginLoadingProvider),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: 1.sh(context) > 400 ? 1.sh(context) : 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Image.asset('images/tichu-logo-transparent.png',
                      width: 250),
                ),
                const Expanded(
                  flex: 6,
                  child: LoginForm(),
                ),
                Expanded(
                  flex: 1,
                  child: const Text(
                    'or',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ).centered(),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyPrimaryButton(
                        text: 'Sign up',
                        onPressed: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignupScreen(),
                        )),
                      ),
                    ],
                  ),
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
