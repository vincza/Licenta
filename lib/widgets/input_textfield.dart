import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Note: This is our main text form field.
class InputTextField extends StatelessWidget {
  final String? initialValue;
  final void Function(String)? onChanged;
  final void Function()? suffixIconFunction;
  final String? Function(String?)? validator;
  final String? additionalText;
  final TextEditingController? controller;
  final void Function()? onTap;
  final String? hint;
  final Color formColor;
  final Color textColor;
  final Color additionalTextColor;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final bool obscureText;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLength;
  final int? maxLines;
  final double? height;
  final BoxShadow? boxShadow;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;

  const InputTextField(
      {Key? key,
      required this.obscureText,
      required this.additionalText,
      required this.initialValue,
      required this.validator,
      required this.onChanged,
      required this.formColor,
      required this.keyboardType,
      required this.textColor,
      required this.additionalTextColor,
      this.hint,
      this.controller,
      this.contentPadding,
      this.suffixIcon,
      this.focusNode,
      this.onTap,
      this.maxLength,
      this.suffixIconFunction,
      this.boxShadow,
      this.maxLines,
      this.height,
      this.inputFormatters,
      this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        additionalText != null
            ? Container(
                alignment: Alignment.topLeft,
                child: Text(
                  additionalText!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: additionalTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              )
            : const SizedBox(),
        Container(
          height: height,
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 5,
          ),
          margin: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
            color: formColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: boxShadow != null ? [boxShadow!] : null,
          ),
          child: TextFormField(
            enabled: enabled,
            inputFormatters: inputFormatters,
            maxLines: maxLines,
            controller: controller,
            obscureText: obscureText,
            focusNode: focusNode,
            maxLength: maxLength,
            initialValue: initialValue,
            keyboardType: keyboardType,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: textColor,
                ),
            decoration: InputDecoration(
              suffixIconConstraints: const BoxConstraints(maxHeight: 20),
              counter: const Offstage(),
              isDense: true,
              border: InputBorder.none,
              hintText: hint,
              suffixIcon: suffixIcon,
              hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: textColor.withOpacity(0.4),
                  ),
            ),
            validator: validator,
            onChanged: onChanged,
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}
