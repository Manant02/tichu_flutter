import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../services/auth.dart';
import '../../utils/show_platform_alert_dialog.dart';
import '../../widgets/my_primary_button.dart';
import '../../widgets/my_textfield.dart';
import '../home/home_screen.dart';
import 'signup_screen.dart';

class SignupForm extends HookConsumerWidget {
  const SignupForm({super.key});

  Future<void> signup(
    String email,
    String username,
    String password,
    NavigatorState navigator,
    WidgetRef ref,
  ) async {
    final auth = Auth();
    ref.read(signupLoadingProvider.notifier).state = true;
    final res = await auth.signup(email, username, password);
    if (res.err == null) {
      auth.navigateBasedOnAuthState(navigator);
      ref.read(signupLoadingProvider.notifier).state = false;
    } else if (res.err == 'email-already-in-use') {
      ref.read(signupLoadingProvider.notifier).state = false;
      showPlatformAlertDialog(
          title: 'Email already in use',
          contentText:
              'An account with this email already exists, please sign in.');
    } else if (res.err == 'weak-password') {
      ref.read(signupLoadingProvider.notifier).state = false;
      showPlatformAlertDialog(
          title: 'Weak password',
          contentText: 'The entered password is too weak.');
    } else {
      ref.read(signupLoadingProvider.notifier).state = false;
      showPlatformAlertDialog(title: 'An error occurred', contentText: res.err);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailTextController = useTextEditingController();
    final usernameTextController = useTextEditingController();
    final passwordTextController = useTextEditingController();
    final confirmPasswordTextController = useTextEditingController();
    const formKey = GlobalObjectKey<FormState>('signup');
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
            label: 'Username',
            controller: usernameTextController,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value.isEmptyOrNull) {
                return 'Please enter a username';
              }
              return null;
            },
          ),
          18.heightBox,
          MyTextField(
            label: 'Password',
            controller: passwordTextController,
            textInputAction: TextInputAction.next,
            obscureText: true,
            validator: (value) {
              if (value.isEmptyOrNull) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          18.heightBox,
          MyTextField(
            label: 'Password',
            controller: confirmPasswordTextController,
            textInputAction: TextInputAction.done,
            obscureText: true,
            validator: (value) {
              if (value.isEmptyOrNull) {
                return 'Please confirm your password';
              }
              if (value != passwordTextController.text) {
                return "Passwords don't match";
              }
              return null;
            },
          ),
          36.heightBox,
          MyPrimaryButton(
            text: 'Sign up',
            onPressed: () {
              if (formKey.currentState!.validate()) {
                signup(
                  emailTextController.text.trim(),
                  usernameTextController.text.trim(),
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
