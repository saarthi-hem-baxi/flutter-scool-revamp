import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/view/home/widget/binge_watch_to_learn/binge_watch_to_learn_list_item.dart';

class BingeWatchToLearn extends StatelessWidget {
  const BingeWatchToLearn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(
          left: 16.w,
          right: 20.w,
        ),
        itemCount: 7,
        itemBuilder: (_, index) {
          return BingeWatchToLearnItem();
        },
      ),
    );
  }
}
