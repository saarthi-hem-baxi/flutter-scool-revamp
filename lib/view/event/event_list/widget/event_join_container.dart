import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_text_styles.dart';

class EventJoinContainer extends StatefulWidget {
  final String title;
  final bool canJoin;
  const EventJoinContainer({
    super.key,
    required this.canJoin,
    required this.title,
  });

  @override
  State<EventJoinContainer> createState() => _EventJoinContainerState();
}

class _EventJoinContainerState extends State<EventJoinContainer> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.r,
        vertical: 10.r,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.title,
              style: AppTextStyle.outFitTextStyle14Light().copyWith(
                color: widget.canJoin ? AppColors.colorWhite : AppColors.gray500,
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: widget.canJoin ? AppColors.color1E3A8A : AppColors.blueGray200,
        borderRadius: BorderRadius.circular(
          100,
        ),
      ),
    );
  }
}
