import 'package:get/get.dart';
import 'package:students/constants/app_data_model.dart';
import 'package:students/constants/app_routes.dart';
import 'package:students/view/auth/login/login_controller.dart';

class SchoolDeactivationController extends GetxController {
  RxBool isOpenSubscriptionPopup = false.obs;

  final LoginController loginController = Get.put(LoginController());

  // navigate to help page
  void navigateToHelpPage({required bool isFromRegistrationLink, required String schoolId}) {
    Get.back();
    Get.toNamed(
      AppRoutes.helpPage,
      arguments: AppDataModel(
        isFromDynamicLink: isFromRegistrationLink,
        schoolId: schoolId,
      ),
    );
  }

  void onCloseBtn() {
    Get.back();
    loginController.logout();
  }
}
