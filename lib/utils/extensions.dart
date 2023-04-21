import 'package:flutter/material.dart';

extension ScreenSizeExtensions on num {
  double sw(BuildContext context) => MediaQuery.of(context).size.width * this;
  double sh(BuildContext context) =>
      (MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top) *
      this;
}
