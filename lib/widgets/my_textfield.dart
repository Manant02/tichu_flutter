import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    this.label,
    this.hint,
    this.validator,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.onFieldSubmitted,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.onSaved,
    this.autofocus = false,
    this.minLines,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onLight = false,
    this.suffixIcon,
    this.focusNode,
    this.showCounter = true,
  }) : super(key: key);

  final String? label;
  final String? hint;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final void Function(String?)? onFieldSubmitted;
  final AutovalidateMode autovalidateMode;
  final Function(String?)? onSaved;
  final bool autofocus;
  final int? minLines;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final bool onLight;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final bool showCounter;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: TextStyle(
              fontSize: 15,
              color: Colors.yellow,
              fontWeight: FontWeight.w900,
            ),
          ).pOnly(left: 8),
        if (label != null) 6.heightBox,
        TextFormField(
          autofocus: autofocus,
          focusNode: focusNode,
          autovalidateMode: autovalidateMode,
          controller: controller,
          validator: validator,
          onSaved: onSaved,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          minLines: minLines,
          maxLines: maxLines,
          maxLength: maxLength,
          maxLengthEnforcement: maxLengthEnforcement,
          decoration: InputDecoration(
            hintText: hint,
            helperText: validator == null ? null : '  ',
            errorMaxLines: 2,
            suffixIcon: suffixIcon,
            suffixIconColor: Colors.white,
            counterText: showCounter ? null : "",
            // counterStyle: Theme.of(context)
            //     .textTheme
            //     .labelMedium!
            //     .copyWith(color: onLight ? Colors.black : Colors.white60),
            // hintStyle: Theme.of(context)
            //     .textTheme
            //     .labelMedium!
            //     .copyWith(color: onLight ? Colors.black : Colors.white60),
            errorStyle: TextStyle(color: Colors.white),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            border: OutlineInputBorder(
              // borderRadius: BorderRadius.circular(11),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.yellow,
          ),
        )
      ],
    );
  }
}
