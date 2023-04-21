import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tichu_flutter/screens/new_table/new_table_form.dart';
import 'package:tichu_flutter/utils/extensions.dart';
import 'package:tichu_flutter/widgets/loading_overlay.dart';
import 'package:tichu_flutter/widgets/my_back_button.dart';
import 'package:tichu_flutter/widgets/my_checkbox.dart';
import 'package:tichu_flutter/widgets/my_primary_button.dart';
import 'package:tichu_flutter/widgets/my_textfield.dart';
import 'package:velocity_x/velocity_x.dart';

final newTableLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

class NewTableScreen extends ConsumerWidget {
  const NewTableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: LoadingOverlay(
          isLoading: ref.watch(newTableLoadingProvider),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: 1.sh(context) > 400 ? 1.sh(context) : 400),
            child: Column(
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
                  flex: 2,
                  child: Column(
                    children: [
                      25.heightBox,
                      const Text(
                        'Create new Table',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  flex: 6,
                  child: NewTableForm(),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
              ],
            ),
          ).scrollVertical(),
        ),
      ),
    );
  }
}
