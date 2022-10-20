import 'package:flutter/material.dart';

import '../../components/app_icons_icons.dart';
import '../../styles/styles.dart';

class CapsuleTextInput extends StatefulWidget {
  const CapsuleTextInput({
    Key? key,
    required this.controller,
    this.hintText,
    this.prefixIcon,
    this.showClearButton = true,
    this.maxHeight = 36,
    this.onChange,
    this.focusNode,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? hintText;
  final IconData? prefixIcon;
  final bool showClearButton;
  final double maxHeight;
  final Function(String)? onChange;

  @override
  State<CapsuleTextInput> createState() => _CapsuleTextInputState();
}

class _CapsuleTextInputState extends State<CapsuleTextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardAppearance: AppColors.of(context).brightness,
      style: AppTextStyles.body,
      controller: widget.controller,
      focusNode: widget.focusNode,
      onChanged: (value) {
        setState(() {});
        if (widget.onChange != null) widget.onChange!(value);
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.of(context).white,
        constraints: BoxConstraints(maxHeight: widget.maxHeight),
        hintText: widget.hintText,
        hintStyle: AppTextStyles.body,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: AppColors.of(context).greyWhisper),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: AppColors.of(context).greyWhisper),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: AppColors.of(context).greyWhisper),
        ),
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                color: AppColors.of(context).black,
              )
            : null,
        suffixIcon:
            (widget.showClearButton && widget.controller.text.isNotEmpty)
                ? GestureDetector(
                    onTap: () {
                      if (widget.onChange != null) widget.onChange!('');
                      widget.focusNode?.unfocus();
                      widget.controller.text = '';
                      setState(() {});
                    },
                    child: Icon(
                      AppIcons.delete_cirlce,
                      color: AppColors.of(context).grey,
                    ),
                  )
                : null,
      ),
      cursorWidth: 2,
      cursorHeight: 18,
      cursorColor: AppColors.of(context).black,
    );
  }
}
