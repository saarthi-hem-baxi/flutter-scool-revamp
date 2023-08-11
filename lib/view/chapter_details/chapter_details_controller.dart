import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:students/constants/app_data_model.dart';
import 'package:students/helpers/network.dart';
import 'package:students/helpers/storage_manager.dart';
import 'package:students/helpers/urls.dart';
import 'package:students/models/chapter/pdf_auth_token.dart';

class ChapterDetailsController extends GetxController {
  APIClient apiClient = APIClient();
  late AppDataModel arguments;
  late PdfAuthToken pdfAuthToken;
  RxBool isLoadedWebView = false.obs;
  RxBool isAnimatedBook = true.obs;
  String url = '';
  RxDouble progress = 0.0.obs;
  RxBool isOpenWebViewPopup = false.obs;

  @override
  void onInit() {
    arguments = Get.arguments as AppDataModel;
    Map data = {
      'book': arguments.bookId,
      'subject': arguments.subjectId,
      'chapter': arguments.chapterId,
    };
    getPDFAuthToken(data: data);
    super.onInit();
  }

  Future<PdfAuthToken> getPDFAuthToken({required Map data}) async {
    try {
      dio.Response response = await apiClient.postData(
        url: APIUrls().lmsUrl + 'teacher-chapter-pdf/pdf-auth-token/',
        data: data,
      );

      if (response.statusCode == 200) {
        pdfAuthToken = pdfAuthTokenFromJson(response.data);
        print(pdfAuthToken.data?.token);
        StorageManager().setPdfAuthToken(pdfAuthToken.data?.token ?? '');
      }
      return pdfAuthToken;
    } on dio.DioException catch (error) {
      if (error.response?.statusCode == 404) {
        Fluttertoast.showToast(msg: 'No Chapters Found');
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong try again');
      }
      return pdfAuthToken;
    }
  }
}
