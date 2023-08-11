import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/widgets/common_app_image.dart';

/// Common app input used in whole app
class CommonAppInput extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String hintText;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final String? prefixIcon;
  final IconData? suffixIcon;
  final bool isShowSuffixIcon;
  final Color suffixIconColor;
  final VoidCallback? onSuffixClick;
  final TextInputAction textInputAction;
  final Function(String)? onChanged;
  final Function(String)? onInputSubmit;
  final Color? fillColor;
  final FocusNode? currentFocusNode;
  final FocusNode? nextFocusNode;
  final bool autoFocus;
  final RegExp? regExp;
  final RegExp? blackListRegExp;

  const CommonAppInput({
    Key? key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.hintText = '',
    this.hintStyle,
    this.style,
    this.prefixIcon,
    this.suffixIcon,
    this.isShowSuffixIcon = true,
    this.suffixIconColor = AppColors.gray500,
    this.onSuffixClick,
    this.textInputAction = TextInputAction.done,
    this.onChanged,
    this.onInputSubmit,
    this.fillColor,
    this.currentFocusNode,
    this.nextFocusNode,
    this.autoFocus = false,
    this.regExp,
    this.blackListRegExp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (value) => onChanged?.call(value),
      onSubmitted: (String text) {
        onInputSubmit?.call(text);
        nextFocusNode?.requestFocus();
      },
      autofocus: autoFocus,
      focusNode: currentFocusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      style: style ?? AppTextStyle.poppinsTextStyle14Regular(color: AppColors.gray500),
      cursorColor: AppColors.gray400,
      decoration: InputDecoration(
        fillColor: fillColor,
        contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.w),
          borderSide: const BorderSide(
            color: AppColors.gray200,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.w),
          borderSide: const BorderSide(
            color: AppColors.gray500,
            width: 1.5,
          ),
        ),
        filled: true,
        border: InputBorder.none,
        hintText: hintText,
        prefixIcon: prefixIcon != null
            ? SizedBox(
                height: 13.w,
                width: 13.w,
                child: CommonAppImage(
                  imagePath: prefixIcon ?? '',
                  fit: BoxFit.none,
                ),
              )
            : const Offstage(),
        suffixIcon: suffixIcon != null && isShowSuffixIcon
            ? InkResponse(
                radius: 25,
                onTap: onSuffixClick,
                child: Icon(
                  suffixIcon,
                  size: 18,
                  color: suffixIconColor,
                ),
              )
            : const Offstage(),
        hintStyle: hintStyle ?? AppTextStyle.poppinsTextStyle14Regular(color: AppColors.gray500),
      ),
      inputFormatters: [
        if (regExp != null) FilteringTextInputFormatter.allow(regExp!),
        if (keyboardType == TextInputType.emailAddress) FilteringTextInputFormatter.deny(RegExp('[ ]')),
        if (blackListRegExp != null) FilteringTextInputFormatter.deny(blackListRegExp!),
      ],
    );
  }
}
