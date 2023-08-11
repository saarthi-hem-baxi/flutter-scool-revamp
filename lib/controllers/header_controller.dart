import 'package:get/state_manager.dart';

class HeaderController extends GetxController {
  RxBool showUpdatePopUp = true.obs;

  void changeStatus() {
    showUpdatePopUp.value = false;
  }
}
