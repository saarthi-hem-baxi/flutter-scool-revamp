import 'package:get/get.dart';
import 'package:students/view/auth/registration/registration_controller.dart';

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegistrationController());
  }
}
