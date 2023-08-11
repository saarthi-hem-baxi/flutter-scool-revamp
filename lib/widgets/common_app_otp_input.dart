import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_text_styles.dart';

class CommonAppOtpInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChange;
  final TextInputAction textInputAction;
  final bool autoFocus;

  const CommonAppOtpInput({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.onChange,
    this.textInputAction = TextInputAction.done,
    this.autoFocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36.sp,
      height: 36.sp,
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        border: Border.all(color: AppColors.blue100, width: 1.w),
      ),
      child: Container(
        margin: const EdgeInsets.all(1),
        color: AppColors.blue25,
        alignment: AlignmentDirectional.center,
        child: TextFormField(
          style: AppTextStyle.nunitoTextStyle20Bold(color: AppColors.color444444),
          controller: controller,
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            fillColor: Colors.white,
          ),
          maxLength: 1,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          textAlign: TextAlign.center,
          focusNode: focusNode,
          textInputAction: TextInputAction.next,
          onChanged: onChange,
        ),
      ),
    );
  }
}
