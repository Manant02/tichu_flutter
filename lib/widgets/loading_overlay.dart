import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    Key? key,
    this.child,
    required this.isLoading,
    this.showModalBarrier = true,
    this.debugText,
  }) : super(key: key);

  final Widget? child;
  final bool isLoading;
  final bool showModalBarrier;
  final String? debugText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (child != null) child!,
        if (isLoading && showModalBarrier)
          const ModalBarrier(
            dismissible: false,
            color: Colors.black45,
          ),
        if (kDebugMode && debugText != null) Text(debugText!).centered(),
        if (isLoading)
          Center(
            child: Platform.isAndroid
                ? const CircularProgressIndicator()
                : const CupertinoActivityIndicator(
                    radius: 15,
                  ),
          ),
      ],
    );
  }
}
