import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tichu_flutter/screens/new_table/new_table_screen.dart';
import 'package:tichu_flutter/screens/tichu_table/tichu_table_screen.dart';
import 'package:tichu_flutter/services/firestore.dart';
import 'package:tichu_flutter/services/providers.dart';
import 'package:tichu_flutter/utils/show_platform_alert_dialog.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/extensions.dart';
import '../../widgets/my_checkbox.dart';
import '../../widgets/my_primary_button.dart';
import '../../widgets/my_textfield.dart';

class NewTableForm extends HookConsumerWidget {
  const NewTableForm({super.key});

  Future<void> createNewTable(
    String name,
    bool shortGame,
    String? password,
    NavigatorState navigator,
    WidgetRef ref,
  ) async {
    final firestore = Firestore();
    ref.read(newTableLoadingProvider.notifier).state = true;

    final tichuUserStream = ref.watch(tichuUserStreamProvider);

    final now = DateTime.now();
    while (tichuUserStream.isLoading &&
        DateTime.now().isBefore(now.add(const Duration(seconds: 10)))) {
      /*wait*/
    }

    if (tichuUserStream.isLoading) {
      showPlatformAlertDialog(
        title: 'Timed out',
        contentText: 'Could not get user info. Please try again.',
        button1OnPressed: () {
          ref.read(newTableLoadingProvider.notifier).state = false;
          navigator.pop();
        },
      );
      return;
    }

    if (tichuUserStream.hasError) {
      showPlatformAlertDialog(
        title: 'Error',
        contentText: tichuUserStream.error.toString(),
        button1OnPressed: () {
          ref.read(newTableLoadingProvider.notifier).state = false;
          navigator.pop();
        },
      );
      return;
    }

    final tichuUser = tichuUserStream.value;
    if (tichuUser == null) {
      showPlatformAlertDialog(
        title: 'Error',
        contentText: 'No user logged in.',
        button1OnPressed: () {
          ref.read(newTableLoadingProvider.notifier).state = false;
          navigator.pop();
        },
      );
      return;
    }
    final res = await firestore.createTichuTable(
        name, shortGame, password, tichuUser.uid);
    if (res.err == null) {
      navigator.push(MaterialPageRoute(
        builder: (context) => TichuTableScreen(tableUid: res.ret!),
      ));
      ref.read(newTableLoadingProvider.notifier).state = false;
    } else {
      showPlatformAlertDialog(
        title: 'Error',
        contentText: res.err,
        button1OnPressed: () {
          ref.read(newTableLoadingProvider.notifier).state = false;
          navigator.pop();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameTextController = useTextEditingController();
    final passwordTextController = useTextEditingController();
    final shortGameState = useState(false);
    const formKey = GlobalObjectKey<FormState>('newTable');
    return Form(
      key: formKey,
      child: Column(
        children: [
          MyTextField(
            label: 'Name',
            controller: nameTextController,
            textInputAction: TextInputAction.next,
            maxLength: 26,
            showCounter: false,
            validator: (value) {
              if (value.isEmptyOrNull) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
          18.heightBox,
          MyTextField(
            label: 'Password (optional)',
            controller: passwordTextController,
            textInputAction: TextInputAction.next,
          ),
          18.heightBox,
          MyCheckBox(
            value: shortGameState.value,
            text: 'Short game (500 pts)',
            onChanged: (newState) {
              if (newState != null) {
                shortGameState.value = newState;
              }
            },
          ),
          36.heightBox,
          MyPrimaryButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                createNewTable(
                  nameTextController.text.trim(),
                  shortGameState.value,
                  passwordTextController.text,
                  Navigator.of(context),
                  ref,
                );
              }
            },
            text: 'Create Table',
          ),
        ],
      ).px(60),
    );
  }
}
