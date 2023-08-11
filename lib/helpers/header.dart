import 'package:dio/dio.dart' as dio;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:students/helpers/app_operation.dart';
import 'package:students/helpers/storage_manager.dart';
import 'package:students/helpers/widget/app_maintenance_dialog.dart';
import 'package:students/helpers/widget/app_update_available_dialog.dart';
import 'package:students/helpers/widget/app_version_expired_dialog.dart';
import 'package:students/models/auth/user.dart';
import 'package:students/view/auth/login/login_controller.dart';
import 'package:students/view/auth/school_deactivation/school_deactivation_controller.dart';
import 'package:students/view/auth/school_deactivation/school_deactivation_page.dart';

/// Handling all header [Request] & [Response] related process
class HeaderHandler {
  LoginController loginController = Get.put(LoginController());
  SchoolDeactivationController schoolDeactivationController = Get.put(SchoolDeactivationController());

  dynamic getHeaders() async {
    return {
      'Content-Type': 'application/json',
      'APP_NAME': getAppName(),
      'APP_VERSION': await getAppCurrentVersion(),
      'UPDATED-USER-AT': await getUpdatedUserAt()
    };
  }

  void handleHeaders(dio.Response? response) async {
    dio.Headers? resHeader = response?.headers;
    if (resHeader?['SESSION_EXPIRED'] != null && resHeader?['SESSION_EXPIRED']?[0] == 'YES') {
      Fluttertoast.showToast(msg: 'Session Expired! Login Again');
      loginController.logout();
    }
    if (resHeader?['APP_NAME_REQUIRED'] != null && resHeader?['APP_NAME_REQUIRED']?[0] == 'YES') {
      Fluttertoast.showToast(msg: 'App name is required');
    } else if (resHeader?['UNKNOWN_APP'] != null && resHeader?['UNKNOWN_APP']?[0] == 'YES') {
      Fluttertoast.showToast(msg: 'App name is unknown');
    } else if (resHeader?['VERSION_REQUIRED'] != null && resHeader?['VERSION_REQUIRED']?[0] == 'YES') {
      Fluttertoast.showToast(msg: 'App version is required');
    } else if (resHeader?['MAINTENANCE'] != null && resHeader?['MAINTENANCE']?[0] == 'YES') {
      AppMaintenanceDialog().showDialog(resHeader);
    } else if (resHeader?['VERSION_EXPIRED'] != null && resHeader?['VERSION_EXPIRED']?[0] == 'YES') {
      AppVersionExpiredDialog().showDialog(resHeader);
    } else if (resHeader?['UPDATE_AVAILABLE'] != null && resHeader?['UPDATE_AVAILABLE']?[0] == 'YES') {
      AppUpdateAvailableDialog().showDialog(resHeader);
    } else if (resHeader?['RENEW_SUBSCRIPTION']?[0] == 'YES') {
      if (schoolDeactivationController.isOpenSubscriptionPopup.value == false) {
        SchoolDeactivationPopUp.showPopUp();
        schoolDeactivationController.isOpenSubscriptionPopup.value = true;
      }
    } else if (resHeader?['RENEW-USER'] != null && resHeader?['RENEW-USER']?[0] == 'YES') {
      loginController.renewUser();
    }
  }

  Future<String> getUpdatedUserAt() async {
    User? user = StorageManager().getCurrentUserFromLocalStorage();
    return user?.updatedAt?.toLocal().toIso8601String() ?? '';
  }
}
