import 'package:get/get.dart';
import 'package:students/view/auth/help/help_controller.dart';

class HelpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HelpController());
  }
}
