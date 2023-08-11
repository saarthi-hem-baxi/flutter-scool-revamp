import 'package:get/get.dart';
import 'package:students/view/auth/school_deactivation/widgets/school_deactivation_widget.dart';

class SchoolDeactivationPopUp {
  static void showPopUp({bool isFromRegistrationLink = false, String schoolId = ''}) {
    Get.dialog(
      SchoolDeactivationPopUpWidget(
        isFromRegistrationLink: isFromRegistrationLink,
        schoolId: schoolId,
      ),
      barrierDismissible: false,
    );
  }
}
