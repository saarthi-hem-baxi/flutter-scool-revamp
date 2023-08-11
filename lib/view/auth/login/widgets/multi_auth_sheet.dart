import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/models/auth/user.dart';
import 'package:students/models/auth/users.dart';
import 'package:students/view/auth/login/login_controller.dart';
import 'package:students/view/auth/login/widgets/login_add_school_btn.dart';
import 'package:students/view/auth/login/widgets/login_school_list_tile.dart';

class MultiAuthBottomSheet {
  void showMultiAuthSheet() {
    LoginController loginController = Get.put(LoginController());

    UsersModal usersModal = loginController.userModal.value;

    if (usersModal.users != null) {
      if ((usersModal.users ?? []).length > 1) {
        List<User> users = usersModal.users ?? [];
        showModalBottomSheet(
            backgroundColor: Colors.white,
            context: Get.context!,
            builder: (context) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                AppStrings.selectUserProfile,
                                style: AppTextStyle.poppinsTextStyle14Medium(color: AppColors.color444444),
                              ),
                            ),
                            const AddSchoolButton()
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        ...users.map(
                          (e) {
                            int index = users.indexOf(e);
                            return SchoolListTile(
                              user: usersModal.users?[index] ?? User(),
                              onTap: () {
                                loginController.onSchoolSelectFromMultiAuthSheet(usersModal.users?[index].id ?? '');
                              },
                              currentUserId: '',
                              isLastItem: index == users.length - 1,
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      } else {
        loginController.onSchoolSelectFromMultiAuthSheet(loginController.userModal.value.users?[0].id ?? '');
      }
    }
  }
}
