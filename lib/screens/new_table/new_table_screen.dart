import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tichu_flutter/widgets/my_back_button.dart';
import 'package:tichu_flutter/widgets/my_checkbox.dart';
import 'package:tichu_flutter/widgets/my_primary_button.dart';
import 'package:tichu_flutter/widgets/my_textfield.dart';
import 'package:velocity_x/velocity_x.dart';

class NewTableScreen extends StatelessWidget {
  const NewTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                const MyBackButton().p(10),
              ],
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  25.heightBox,
                  Text(
                    'Create new Table',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                children: [
                  MyTextField(
                    label: 'Name',
                  ),
                  18.heightBox,
                  MyTextField(
                    label: 'Password (optional)',
                  ),
                  18.heightBox,
                  MyCheckBox(
                    value: true,
                    text: 'Short game (500 pts)',
                  ),
                  36.heightBox,
                  MyPrimaryButton(
                    onPressed: () {},
                    text: 'Create Table',
                  ),
                ],
              ).px(60),
            ),
            Expanded(
              flex: 4,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
