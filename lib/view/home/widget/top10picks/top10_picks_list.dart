import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/view/home/widget/top10picks/top10_picks_list_item.dart';

class Top10PicksWidget extends StatefulWidget {
  const Top10PicksWidget({
    super.key,
  });

  @override
  State<Top10PicksWidget> createState() => _Top10PicksWidgetState();
}

class _Top10PicksWidgetState extends State<Top10PicksWidget> {
  final ScrollController scrollController = ScrollController();
  double scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      setState(() {
        scrollOffset = scrollController.offset;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200.h,
          child: ListView.builder(
            controller: scrollController,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(
              left: 16.w,
              right: 20.w,
            ),
            itemCount: 7,
            itemBuilder: (_, index) {
              return Top10PicksItem();
            },
          ),
        ),
        Positioned(
          left: -5.0,
          top: -8.h,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: scrollOffset == 0 ? 0 : 1,
            child: InkWell(
              onTap: () {
                scrollController.animateTo(scrollOffset = scrollOffset - 152.w,
                    duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
              },
              child: SizedBox(
                width: 35.w,
                height: 210.h,
                child: Container(
                  // color: AppColors.color13214D,
                  width: 30.w,
                  height: 210.h,
                  padding: EdgeInsets.only(right: 5.w),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.color13214D.withOpacity(0.6),
                        offset: const Offset(0, 4),
                        blurRadius: 8,
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.colorWhite,
                    size: 18,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: -5.0,
          top: -8.h,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: (scrollController.hasClients
                    ? scrollOffset == scrollController.position.maxScrollExtent
                    : scrollOffset != 0)
                ? 0
                : 1,
            child: InkWell(
              onTap: () {
                scrollController.animateTo(scrollOffset = scrollOffset + 152.w,
                    duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
              },
              child: SizedBox(
                width: 35.w,
                height: 210.h,
                child: Container(
                  // color: AppColors.color13214D,
                  width: 30.w,
                  height: 210.h,
                  padding: EdgeInsets.only(right: 5.w),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.color13214D.withOpacity(0.6),
                        offset: const Offset(0, 4),
                        blurRadius: 8,
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.colorWhite,
                    size: 18,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
