import 'package:get/get.dart';
import 'package:students/constants/app_data_model.dart';
import 'package:students/helpers/network.dart';

class LeaderBoardController extends GetxController {
  APIClient apiClient = APIClient();
  late AppDataModel arguments;
}
