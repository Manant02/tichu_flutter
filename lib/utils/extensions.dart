import 'package:flutter/material.dart';

extension ScreenSizeExtensions on num {
  double sw(BuildContext context) => MediaQuery.of(context).size.width * this;
  double sh(BuildContext context) =>
      (MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top) *
      this;
}

extension ListExtensions on List {
  List boolFilter(List<bool> filter) =>
      where((element) => filter[indexOf(element)]).toList();
}

extension NListExtnsions on List? {
  bool get isEmptyOrNull => this?.isEmpty ?? true;
  bool get isNotEmptyOrNotNull => this?.isNotEmpty ?? false;
}
