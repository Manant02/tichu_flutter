import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tichu_flutter/screens/home/home_screen.dart';
import 'package:tichu_flutter/screens/login/login_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../services/auth.dart';
import '../../utils/show_platform_alert_dialog.dart';
import '../../widgets/my_checkbox.dart';
import '../../widgets/my_primary_button.dart';
import '../../widgets/my_textfield.dart';

class LoginForm extends HookConsumerWidget {
  const LoginForm({super.key});

  Future<void> login(
    String email,
    String password,
    NavigatorState navigator,
    WidgetRef ref,
  ) async {
    final auth = Auth();
    ref.read(loginLoadingProvider.notifier).state = true;
    final res = await auth.login(email, password);
    if (res.err == null) {
      auth.navigateBasedOnAuthState(navigator);
      ref.read(loginLoadingProvider.notifier).state = false;
    } else if (res.err == 'user-not-found') {
      showPlatformAlertDialog(
          title: 'User not found',
          contentText: 'No user with this email was found. Try signing up.');
      ref.read(loginLoadingProvider.notifier).state = false;
    } else if (res.err == 'wrong-password') {
      showPlatformAlertDialog(
          title: 'Wrong password',
          contentText:
              'The entered password is incorrect. Please try again, or reset your password.');
      ref.read(loginLoadingProvider.notifier).state = false;
    } else {
      showPlatformAlertDialog(title: 'An error occurred', contentText: res.err);
      ref.read(loginLoadingProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailTextController = useTextEditingController();
    final passwordTextController = useTextEditingController();
    const formKey = GlobalObjectKey<FormState>('login');
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyTextField(
            label: 'Email',
            controller: emailTextController,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value.isEmptyOrNull) {
                return 'Please enter your email address';
              }
              return null;
            },
          ),
          18.heightBox,
          MyTextField(
            label: 'Password',
            controller: passwordTextController,
            textInputAction: TextInputAction.done,
            obscureText: true,
            validator: (value) {
              if (value.isEmptyOrNull) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          36.heightBox,
          MyPrimaryButton(
            text: 'Log in',
            onPressed: () {
              if (formKey.currentState!.validate()) {
                login(
                  emailTextController.text.toLowerCase().trim(),
                  passwordTextController.text,
                  Navigator.of(context),
                  ref,
                );
              }
            },
          ),
        ],
      ).px(60),
    );
  }
}
