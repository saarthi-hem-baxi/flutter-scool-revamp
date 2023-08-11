import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/widgets/common_app_image.dart';

/// Common app input used in whole app
class CommonAppInputFloating extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final double borderRadius;
  final String labelText;
  final TextStyle? style;
  final TextStyle? floatingLabelStyle;
  final TextStyle? labelStyle;
  final String? prefixIcon;
  final String? suffixIcon;
  final Color? suffixIconColor;
  final VoidCallback? onSuffixClick;
  final TextInputAction textInputAction;
  final RegExp? regExp;
  final RegExp? blackListRegExp;
  final int maxLength;
  final Function(String)? onChange;
  final Function(String)? onInputSubmit;
  final Function()? onTap;
  final bool isEnableInputBox;
  final bool isDescBox;
  final int? minLine;
  final int? maxLine;
  final bool alignLabelWithHint;
  final FocusNode? currentFocusNode;
  final FocusNode? nextFocusNode;
  final bool isEnableSuggestions;
  final bool autoFocus;
  final Color? fillColor;
  final EdgeInsets? scrollPadding;
  final Color? enableBorderColor;
  final EdgeInsets? padding;

  const CommonAppInputFloating({
    Key? key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.borderRadius = 100,
    this.labelText = '',
    this.style,
    this.floatingLabelStyle,
    this.labelStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconColor,
    this.onSuffixClick,
    this.textInputAction = TextInputAction.done,
    this.regExp,
    this.blackListRegExp,
    this.maxLength = 500,
    this.onChange,
    this.onInputSubmit,
    this.onTap,
    this.isEnableInputBox = true,
    this.isDescBox = false,
    this.minLine,
    this.maxLine,
    this.alignLabelWithHint = false,
    this.currentFocusNode,
    this.nextFocusNode,
    this.isEnableSuggestions = false,
    this.autoFocus = false,
    this.fillColor,
    this.scrollPadding,
    this.enableBorderColor,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.only(left: 10, right: 10, top: 10),
      height: maxLine == null ? 65 : null,
      child: TextField(
        focusNode: currentFocusNode,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLength: maxLength,
        textInputAction: textInputAction,
        textCapitalization: TextCapitalization.sentences,
        enableSuggestions: isEnableSuggestions,
        scrollPadding: scrollPadding ?? EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        autocorrect: false,
        autofocus: autoFocus,
        onSubmitted: (String text) {
          onInputSubmit?.call(text);
          nextFocusNode?.requestFocus();
        },
        onChanged: onChange,
        onTap: onTap,
        enabled: isEnableInputBox,
        maxLines: maxLine ?? (isDescBox ? 8 : 1),
        minLines: minLine ?? (isDescBox ? 3 : 1),
        style: style ?? AppTextStyle.poppinsTextStyle16Regular(color: AppColors.gray700),
        decoration: InputDecoration(
          fillColor: fillColor ?? AppColors.colorTransparent,
          filled: true,
          prefixIconConstraints: const BoxConstraints(maxWidth: 38, maxHeight: 38),
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 15, right: 7),
                  child: Image.asset(prefixIcon!, color: AppColors.color999999, width: 18),
                )
              : null,
          suffixIconConstraints: suffixIcon != null ? const BoxConstraints(maxWidth: 42, maxHeight: 42) : null,
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 7, right: 7),
                  child: InkResponse(
                    radius: 15,
                    onTap: onSuffixClick,
                    child: CommonAppImage(imagePath: suffixIcon!, color: suffixIconColor, width: 24),
                  ),
                )
              : null,
          isDense: true,
          labelStyle: labelStyle ?? AppTextStyle.poppinsTextStyle16Regular(color: AppColors.gray600),
          floatingLabelStyle: floatingLabelStyle ?? AppTextStyle.poppinsTextStyle18Medium(color: AppColors.gray600),
          contentPadding: EdgeInsets.only(bottom: 6.h, top: 2.h),
          labelText: labelText,
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          alignLabelWithHint: alignLabelWithHint,
          counter: const Offstage(),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: enableBorderColor ?? AppColors.gray300,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.gray300,
            ),
          ),
        ),
        inputFormatters: [
          if (regExp != null) FilteringTextInputFormatter.allow(regExp!),
          if (keyboardType == TextInputType.emailAddress) FilteringTextInputFormatter.deny(RegExp('[ ]')),
          if (blackListRegExp != null) FilteringTextInputFormatter.deny(blackListRegExp!),
        ],
      ),
    );
  }
}
