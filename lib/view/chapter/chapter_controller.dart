import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:students/constants/app_class.dart';
import 'package:students/constants/app_data_model.dart';
import 'package:students/helpers/network.dart';
import 'package:dio/dio.dart' as dio;
import 'package:students/helpers/urls.dart';
import 'package:students/models/chapter/chapter_model.dart';
import 'package:students/models/home/chapter_list_model.dart';

class ChapterController extends GetxController {
  APIClient apiClient = APIClient();
  late AppDataModel arguments;

  RxList<Quarters>? chapterList = <Quarters>[].obs;
  List<ChapterNameListModel>? chapterNameList = <ChapterNameListModel>[].obs;
  late ChapterListModel chapterListModel;

  @override
  void onInit() {
    super.onInit();
    arguments = Get.arguments as AppDataModel;
    readJson();

    Future.delayed(Duration.zero, () {
      getChapters(arguments.subjectId ?? '');
    });
  }

  void readJson() async {
    final String response = await rootBundle.loadString('assets/chapter_dummy.json');
    final data = await json.decode(response);
    chapterListModel = ChapterListModel.fromJson(data);
  }

  void getChapters(String subjectId) async {
    AppClass().showLoading(true);
    List<Months> months = [];
    List<Chapters> chapters = [];
    try {
      dio.Response response = await apiClient.getData(
        url: APIUrls().lmsStudentUrl + 'subject/$subjectId/chapters/learn',
      );
      if (response.statusCode == 200) {
        chapterNameList = chapterListModelFromJson(response.data['data']);

        for (ChapterNameListModel name in chapterNameList ?? []) {
          chapters.add(Chapters(
            chapterName: name.name,
            obtainMark: 10,
            totalMark: 20,
            orderNumber: name.orderNumber,
            bookId: name.bookId,
            bookName: name.bookName,
            chapterId: name.id,
            conceptMap: name.conceptMap,
          ));
        }
        months.add(Months(chapters: chapters));
        chapterList?.add(
          Quarters(
            title: 'QUARTER 1',
            months: months,
          ),
        );
        AppClass().showLoading(false);
        print(chapterList);
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
}
