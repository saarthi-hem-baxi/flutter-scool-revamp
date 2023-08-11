import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/communication_image_assets.dart';
import 'package:students/helpers/utils.dart';
import 'package:students/view/communication/communication_feed_list.dart';
import 'package:students/view/communication/communication_search.dart';
import 'package:students/view/communication/communication_subject_view.dart';
import 'package:students/view/communication/communication_teacher_wise_view.dart';
import 'package:students/widgets/status_color_manager.dart';

int selectedItem = 1;

class CommunicationFeed extends StatefulWidget {
  const CommunicationFeed({Key? key}) : super(key: key);

  @override
  State<CommunicationFeed> createState() => _CommunicationFeedState();
}

class _CommunicationFeedState extends State<CommunicationFeed> {
  @override
  void initState() {
    selectedItem = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatusBarColorManager(
      color: AppColors.colorWhite,
      child: Scaffold(
        backgroundColor: AppColors.colorF6F6F6,
        body: SafeArea(
          child: Column(
            children: [
              HeaderComponent(reloadPage: reloadPage),
              // PinnedMessagesComponent(),
              Expanded(
                child: (() {
                  if (selectedItem == 1) {
                    return Container(
                      child: CommunicationFeedList(isScrollable: true),
                    );
                  } else if (selectedItem == 2) {
                    return CommunicationTeacherWiseView();
                  } else {
                    return CommunicationSubjectView();
                  }
                }()),
              )
            ],
          ),
        ),
      ),
    );
  }

  void reloadPage() {
    setState(() {});
  }
}

class PinnedMessagesComponent extends StatelessWidget {
  const PinnedMessagesComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      color: AppColors.colorWhite.withOpacity(0.8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                CommunicationImageAssets.activepinIcon,
                height: 18.h,
                width: 18.w,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                AppStrings.pinned_msg,
                style: AppTextStyle.readexTextStyle12Regular(
                  color: AppColors.gray500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.w),
                decoration: BoxDecoration(
                  color: AppColors.gray200,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Text(
                  '35',
                  style: AppTextStyle.readexTextStyle14Regular(
                    color: AppColors.gray500,
                  ).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                width: 15.w,
              ),
              Icon(
                Icons.arrow_forward,
                color: AppColors.gray500,
                size: 25.h,
              )
            ],
          )
        ],
      ),
    );
  }
}

class HeaderComponent extends StatefulWidget {
  const HeaderComponent({
    Key? key,
    required this.reloadPage,
  }) : super(key: key);

  final Function reloadPage;

  @override
  State<HeaderComponent> createState() => _HeaderComponentState();
}

class _HeaderComponentState extends State<HeaderComponent> {
  List<String> filterItems = [
    'Yesterday',
    'Older than a month',
    'Last 7 days',
    'Older than 6 month',
    'Last 30 days',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      color: AppColors.colorWhite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColors.gray50,
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.gray900,
                      size: 25.h,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                (() {
                  if (selectedItem == 1) {
                    return Row(
                      children: [
                        Image.asset(
                          CommunicationImageAssets.headerIcon,
                          height: 30.h,
                          width: 30.w,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                      ],
                    );
                  } else {
                    return SizedBox(
                      width: 0,
                    );
                  }
                }()),
                Flexible(
                  child: Text(
                    (() {
                      if (selectedItem == 1) {
                        return 'Maharaja Agrasen Public School';
                      } else {
                        return 'Communication';
                      }
                    }()),
                    style: AppTextStyle.readexTextStyle18Medium(
                      color: AppColors.gray800,
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CommunicationSearch(),
                    ),
                  );
                },
                child: SizedBox(
                  height: 32.h,
                  width: 32.h,
                  child: Icon(
                    Icons.search,
                    color: AppColors.blueGray600,
                  ),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 70.w,
                                    height: 6.h,
                                    margin: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: AppColors.gray200,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Filter by date',
                                  style: AppTextStyle.poppinsTextStyle18Medium(color: AppColors.gray800),
                                ),
                                SizedBox(
                                  height: 16.w,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle_outlined,
                                      size: 16.h,
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Text(
                                      'Custom date range',
                                      style: AppTextStyle.poppinsTextStyle14Regular(color: AppColors.gray600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: 4.5,
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            children: List.generate(
                              filterItems.length,
                              (index) => Row(
                                children: [
                                  Icon(
                                    Icons.circle_outlined,
                                    size: 16.h,
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text(
                                    filterItems[index],
                                    style: AppTextStyle.poppinsTextStyle14Regular(color: AppColors.gray600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      );
                    },
                  );
                },
                child: SizedBox(
                  height: 32.h,
                  width: 32.h,
                  child: Icon(
                    Icons.filter_alt,
                    // size: 24.w,
                    color: AppColors.blueGray600,
                  ),
                ),
              ),
              PopupMenuButton<int>(
                constraints: BoxConstraints(
                  maxWidth: 225.w,
                ),
                position: PopupMenuPosition.over,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    padding: EdgeInsets.zero,
                    child: Container(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(maxWidth: 240.w),
                      color: selectedItem == 1
                          ? AppColors.blue100
                          : AppColors.blue25, // Change this to the desired background color for the selected item
                      child: ListTile(
                        dense: true,
                        minLeadingWidth: 32.w,
                        contentPadding: EdgeInsets.only(left: 10.w),
                        leading: selectedItem == 1 ? Icon(Icons.check_outlined) : SizedBox(),
                        title: Text(
                          'Feed view',
                          style: AppTextStyle.readexTextStyle14SemiBold(color: AppColors.blueGray700),
                        ),
                        // Keep the same text color for all items
                        // For example, you can set it to white
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    padding: EdgeInsets.zero,
                    child: Container(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(maxWidth: 240.w),
                      color: selectedItem == 2
                          ? AppColors.blue100
                          : AppColors.blue25, // Change this to the desired background color for the selected item
                      child: ListTile(
                        contentPadding: EdgeInsets.only(left: 10.w),
                        trailing: SizedBox(
                          width: 10.w,
                        ),
                        dense: true,
                        minLeadingWidth: 32.w,
                        leading: selectedItem == 2 ? Icon(Icons.check_outlined) : SizedBox(),
                        title: Text(
                          'Teacher-wise view',
                          style: AppTextStyle.readexTextStyle14SemiBold(color: AppColors.blueGray700),
                        ),
                        // Keep the same text color for all items
                        // For example, you can set it to white
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 3,
                    padding: EdgeInsets.zero,
                    child: Container(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(maxWidth: 240.w),
                      color: selectedItem == 3
                          ? AppColors.blue100
                          : AppColors.blue25, // Change this to the desired background color for the selected item
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.only(left: 10.w),
                        minLeadingWidth: 32.w,
                        leading: selectedItem == 3 ? Icon(Icons.check_outlined) : SizedBox(),
                        title: Text(
                          'Subject view',
                          style: AppTextStyle.readexTextStyle14SemiBold(color: AppColors.blueGray700),
                        ),
                        // Keep the same text color for all items
                        // For example, you can set it to white
                      ),
                    ),
                  ),
                ],
                initialValue: 2,
                onCanceled: () {
                  print('You have canceled the menu.');
                },
                onSelected: (value) {
                  setState(() {
                    selectedItem = value;
                    widget.reloadPage();
                  });
                  print('value:$value');
                },
                icon: SizedBox(
                  height: 32.h,
                  width: 32.h,
                  child: Icon(
                    Icons.more_vert,
                    // size: 24.w,
                    color: AppColors.blueGray600,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  PopupMenuItem<String> chapterItemPopupMenu({required String menuIcon, required String menuTitle}) {
    return PopupMenuItem<String>(
      onTap: () {
        print(menuTitle);
      },
      padding: EdgeInsets.zero,
      child: Container(
        height: 40.h,
        width: Utils.getScreenWidth * 0.4,
        padding: EdgeInsets.zero,
        color: menuTitle == 'Feed View' ? AppColors.red : AppColors.colorWhite,
        child: Row(
          children: [
            SizedBox(
              width: 16.w,
            ),
            SvgPicture.asset(
              menuIcon,
              height: 15.h,
              width: 15.w,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              menuTitle,
              style: AppTextStyle.readexTextStyle14Regular().copyWith(
                color: AppColors.blueGray700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      value: menuTitle,
    );
  }
}
