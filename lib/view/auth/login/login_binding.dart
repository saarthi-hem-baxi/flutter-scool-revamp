import 'package:get/get.dart';
import 'package:students/view/auth/login/login_controller.dart';
import 'package:students/view/auth/registration/registration_with_link_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => RegistrationWithLinkController());
  }
}
