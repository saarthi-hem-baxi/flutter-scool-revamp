import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_class.dart';
import 'package:students/constants/home_image_assets.dart';
import 'package:students/helpers/network.dart';
import 'package:students/helpers/storage_manager.dart';
import 'package:students/helpers/urls.dart';
import 'package:students/models/auth/user.dart';
import 'package:students/models/home/subject_list_model.dart';
import 'package:students/models/home/subject_name_list_model.dart';
import 'package:dio/dio.dart' as dio;

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  late Rx<AnimationController> animationController;
  late Animation<double> animation;

  Rx<User?> user = User().obs;

  APIClient apiClient = APIClient();

  RxList<SubjectListModel> subjectList = <SubjectListModel>[].obs;
  List<SubjectNameModel> subjectNameList = <SubjectNameModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(duration: const Duration(seconds: 10), vsync: this).obs;
    animation = CurvedAnimation(parent: animationController.value, curve: Curves.bounceInOut);
    animationController.value.forward(from: 0.5);
    user.value = StorageManager().getCurrentUserFromLocalStorage();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => getSubjects());
  }

  void getSubjects() async {
    subjectList.clear();
    List<Color> subjectBubbleColor = [
      Color(0xffFB7A16),
      Color(0xff168439),
      Color(0xff1B8DFD),
      Color(0xff003370),
      Color(0xffD12548),
      Color(0xffCACE00),
      Color(0xffB7188D),
      Color(0xff009999),
    ];

    List<Color> subjectColor = [
      Color(0xffFDA531),
      Color(0xff2CAA72),
      Color(0xff35B3FF),
      Color(0xff004596),
      Color(0xffDE3D73),
      Color(0xffDADE07),
      Color(0xffA71681),
      Color(0xff00B3B2),
    ];
    List<String> subjectIcons = [
      HomeImageAssets.maths,
      HomeImageAssets.socialScience,
      HomeImageAssets.numeracy,
      HomeImageAssets.hindi,
      HomeImageAssets.environmentalScience,
      HomeImageAssets.science,
      HomeImageAssets.hindiGrammer,
      HomeImageAssets.englishGrammer,
    ];
    AppClass().showLoading(true);
    try {
      dio.Response response = await apiClient.getData(
        url: APIUrls().lmsStudentUrl + 'subject/learn',
      );
      if (response.statusCode == 200) {
        subjectNameList = subjectNameModelFromJson(response.data['data']);

        // for (SubjectNameModel name in subjectNameList) {
        //   subjectList.add(
        //     SubjectListModel(
        //       id: name.id,
        //       name: name.name ?? '',
        //       bgColor: const Color(0xffFDA531),
        //       bubbleColor: const Color(0xffFB7A16),
        //       emoji: '😍',
        //       gif: HomeImageAssets.maths,
        //     ),
        //   );
        // }
        for (int i = 0; i < subjectNameList.length; i++) {
          SubjectNameModel subjectData = subjectNameList[i];
          subjectList.add(
            SubjectListModel(
              subjectId: subjectData.id,
              name: subjectData.name ?? '',
              bgColor: i < 8 ? subjectColor[i] : subjectColor[i % 8],
              bubbleColor: i < 8 ? subjectBubbleColor[i] : subjectBubbleColor[i % 8],
              emoji: '😍',
              gif: i < 8 ? subjectIcons[i] : subjectIcons[i % 8],
            ),
          );
        }
        AppClass().showLoading(false);
      }
    } on dio.DioError catch (error) {
      AppClass().showLoading(false);
      if (error.response?.statusCode == 404) {
        Fluttertoast.showToast(msg: 'No Chapters Found');
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong try again');
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
    animationController.value.dispose();
  }
}
