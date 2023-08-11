import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_gradients.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/auth_image_assets.dart';
import 'package:students/models/auth/user.dart';
import 'package:students/widgets/common_app_image.dart';

class SchoolListTile extends StatelessWidget {
  const SchoolListTile({
    Key? key,
    required this.currentUserId,
    required this.user,
    required this.onTap,
    this.onProfileTap,
    required this.isLastItem,
  }) : super(key: key);

  final User user;
  final String currentUserId;
  final VoidCallback onTap;
  final VoidCallback? onProfileTap;
  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            margin: EdgeInsets.symmetric(vertical: 5.h),
            child: Row(
              children: [
                (user.thumb != null && user.thumb!.isNotEmpty)
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CommonAppImage(
                          imagePath: user.thumb ?? '',
                          width: 60.w,
                          height: 60.w,
                        ))
                    : Icon(
                        Icons.account_circle_rounded,
                        size: 70.w,
                        color: AppColors.colorA3A3A3,
                      ),
                SizedBox(
                  width: 10.w,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name == null ? ('${user.firstName} ${user.lastName}') : ('${user.name}'),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.poppinsTextStyle20Medium(color: AppColors.color0F5BE0),
                      ),
                      Text(
                        user.school?.name ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.poppinsTextStyle14Regular(color: AppColors.color444444),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              'Class ${user.userClass?.name} ${user.section?.name}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.poppinsTextStyle14SemiBold(color: AppColors.color444444),
                            ),
                          ),
                          currentUserId == user.id
                              ? GestureDetector(
                                  onTap: onProfileTap ?? () {},
                                  child: Container(
                                    alignment: AlignmentDirectional.topStart,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(6)),
                                        gradient: AppGradients.pinkGradient,
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Center(
                                            child: Text(
                                              AppStrings.viewProfile,
                                              style: AppTextStyle.nunitoTextStyle12Regular().copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          const Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: 14.h,
                                  width: 20.w,
                                  child: CommonAppImage(
                                    imagePath: AuthImageAssets.rightArrow,
                                  ),
                                )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          isLastItem
              ? const SizedBox()
              : const Divider(
                  color: AppColors.gray300,
                  height: 1,
                )
        ],
      ),
    );
  }
}
