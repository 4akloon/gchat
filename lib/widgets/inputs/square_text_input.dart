import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gchat/utils/validators/validation_rule.dart';
import 'package:gchat/widgets/inputs/custom_input_border.dart';

import '../../styles/styles.dart';
import '../../utils/formatters/phone_formatter.dart';

class SquareTextInput extends StatefulWidget {
  const SquareTextInput({
    Key? key,
    required this.controller,
    this.labelText,
    this.minHeight = 48,
    required this.onChange,
    this.focusNode,
    this.formatters = const [],
    this.validation,
    this.suffixWidget,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? labelText;
  final double minHeight;
  final Function(String) onChange;
  final List<TextInputFormatter> formatters;
  final ValidationRule? validation;
  final Widget? suffixWidget;

  factory SquareTextInput.phone({
    required TextEditingController controller,
    FocusNode? focusNode,
    String? labelText,
    required Function(String) onChange,
    Widget? suffixWidget,
  }) =>
      SquareTextInput(
        controller: controller,
        focusNode: focusNode,
        onChange: (v) => onChange(PhoneFormatter.cleanPhone(v)!),
        labelText: labelText,
        formatters: [PhoneFormatter()],
        validation: PhoneValidator(),
        suffixWidget: suffixWidget,
      );

  @override
  State<SquareTextInput> createState() => _SquareTextInputState();
}

class _SquareTextInputState extends State<SquareTextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardAppearance: AppColors.of(context).brightness,
      inputFormatters: widget.formatters,
      style: AppTextStyles.body,
      controller: widget.controller,
      focusNode: widget.focusNode,
      onChanged: (value) {
        setState(() {});
        widget.onChange(value);
      },
      validator: widget.validation?.validateInput,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.of(context).whiteSmoke,
        constraints: BoxConstraints(minHeight: widget.minHeight),
        label: widget.labelText != null
            ? Text(
                widget.labelText!,
                style: TextStyle(color: AppColors.of(context).grey),
              )
            : null,
        border: const CustomInputBorder(borderSide: BorderSide.none),
        focusedBorder: const CustomInputBorder(borderSide: BorderSide.none),
        enabledBorder: const CustomInputBorder(borderSide: BorderSide.none),
        prefixText: '+380 ',
        prefixStyle: AppTextStyles.body,
        suffixIcon: widget.suffixWidget,
      ),
      cursorWidth: 2,
      cursorHeight: 18,
      cursorColor: AppColors.of(context).black,
    );
  }
}
