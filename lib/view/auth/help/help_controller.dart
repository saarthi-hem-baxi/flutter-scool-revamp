import 'package:dio/dio.dart' as dio;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_class.dart';
import 'package:students/constants/app_data_model.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/helpers/network.dart';
import 'package:students/helpers/urls.dart';
import 'package:students/models/auth/help_contact.dart';

class HelpController extends GetxController {
  APIClient apiClient = APIClient();
  late AppDataModel arguments;

  Rx<HelpPageContactModal> helpPageContactData = HelpPageContactModal().obs;

  @override
  void onInit() {
    super.onInit();
    arguments = Get.arguments as AppDataModel;
    Future.delayed(Duration.zero, () {
      getSupportExecutiveDetails(schoolId: arguments.schoolId ?? '');
    });
  }

  /// get data of support executives using school id
  ///
  /// when school id is null or empty it's return global support executive contact number
  void getSupportExecutiveDetails({required String schoolId}) async {
    AppClass().showLoading(true);
    try {
      dio.Response response = await apiClient.getData(
        url: '${APIUrls().authUrl}support-person/detail?schoolId=$schoolId',
      );
      if (response.statusCode == 200) {
        helpPageContactData.value = HelpPageContactModal.fromJson(response.data['data']);
        AppClass().showLoading(false);
      }
    } catch (error) {
      Fluttertoast.showToast(msg: AppStrings.cannotGetHelpPageData);
      AppClass().showLoading(false);
    }
  }
}
