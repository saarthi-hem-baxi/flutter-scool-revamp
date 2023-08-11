import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart' as getx;
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/controllers/download_controller.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

enum MediaTypes { audio, video, doc, pdf, image, link, simulation }

final List<String> allowedImagedFormat = [
  'jpg',
  'jpeg',
  'png',
  'heic',
  'JPG',
  'JPEG',
  'PNG',
  'HEIC',
];

final List<String> docTypes = [
  'ppt',
  'pdf',
  'doc',
  'docx',
  'xls',
  'xlsx',
  'pptx',
];

final List<String> audioTypes = ['mp3', 'wav', 'aac'];
final List<String> videoTypes = [
  'mp4',
  'mkv',
  'mov',
  '3gp',
  'avi',
  'hevc',
  'MP4',
  'MKV',
  'MOV',
  '3GP',
  'AVI',
  'HEVC',
];
final List<String> imageTypes = [
  'jpg',
  'jpeg',
  'png',
  'svg',
  'heic',
  'JPG',
  'JPEG',
  'PNG',
  'SVG',
  'HEIC',
];

MediaTypes getMediaTypeFromUrl(String url) {
  String ext = url.split('.').last.toLowerCase();
  if (imageTypes.map((e) => e.toLowerCase()).contains(ext)) {
    return MediaTypes.image;
  } else if (audioTypes.map((e) => e.toLowerCase()).contains(ext)) {
    return MediaTypes.audio;
  } else if (isYoutubeUrl(url: url)) {
    return MediaTypes.video;
  } else if (videoTypes.map((e) => e.toLowerCase()).contains(ext)) {
    return MediaTypes.video;
  } else if (ext == 'pdf') {
    return MediaTypes.pdf;
  } else if (docTypes.map((e) => e.toLowerCase()).contains(ext)) {
    return MediaTypes.doc;
  } else {
    return MediaTypes.link;
  }
}

bool isExtensionExistInUrl({required String url}) {
  final String fileExtension = url.split('.').last;
  RegExp specialChar = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%-]');
  bool isExtensionExist = !specialChar.hasMatch(fileExtension);
  return isExtensionExist;
}

bool isYoutubeUrl({required String url}) {
  RegExp youtubeUrlRegex = RegExp(
      r'(?:http?s?:\/\/)?(?:www.)?(?:m.)?(?:music.)?youtu(?:\.?be)(?:\.com)?(?:(?:\w*.?:\/\/)?\w*.?\w*-?.?\w*\/(?:embed|e|v|watch|.*\/)?\??(?:feature=\w*\.?\w*)?&?(?:v=)?\/?)([\w\d_-]{11})(?:\S+)?');
  bool isYoutubeUrl = youtubeUrlRegex.hasMatch(url);
  return isYoutubeUrl;
}

bool isLocalFileUrl({required String url}) {
  Uri uri = Uri.parse(url);
  if (uri.isAbsolute) {
    return false;
  } else {
    return true;
  }
}

bool isNetworkUrl(String url) {
  if (url.startsWith('http') || url.startsWith('https')) {
    return true;
  } else {
    return false;
  }
}

void openLocalMediaFile({required String path}) {
  OpenFile.open(path).then((OpenResult value) {}).catchError((v) {
    debugPrint('Cannot open local file ${v.toString()}');
    Fluttertoast.showToast(msg: AppStrings.someThingWentWrong);
  });
}

dynamic generateThumbnail({required String url}) async {
  String? thumbPath = await VideoThumbnail.thumbnailFile(
    video: url,
    thumbnailPath: (await getTemporaryDirectory()).path,
    imageFormat: ImageFormat.PNG,
  );
  return thumbPath;
}

bool isURLTypeImage(String url) {
  return url.contains('png') ||
      url.contains('PNG') ||
      url.contains('jpg') ||
      url.contains('JPG') ||
      url.contains('jpeg') ||
      url.contains('JPEG') ||
      url.contains('tiff') ||
      url.contains('TIFF') ||
      url.contains('svg') ||
      url.contains('SVG') ||
      url.contains('heic') ||
      url.contains('HEIC');
}

void downloadOpen(
  String url,
) async {
  if (url.contains('http')) {
    var dio = Dio();
    var tempDir = await getTemporaryDirectory();
    String fullPath = tempDir.path + "/'" + (url.split('/').isNotEmpty ? url.split('/')[url.split('/').length - 1] : '');

    download2(dio, url, fullPath).then((String path) {
      OpenFile.open(path).then((OpenResult value) {});
    });
  } else {
    Fluttertoast.showToast(msg: AppStrings.invalidURL);
  }
}

Future<String> download2(Dio dio, String url, String savePath) async {
  DownloadController downloadController = getx.Get.put(DownloadController());
  downloadController.downloadProgress.value = 0;
  try {
    getx.Get.defaultDialog(
      barrierDismissible: true,
      title: '',
      radius: 1.w,
      titlePadding: EdgeInsets.zero,
      content: WillPopScope(
        onWillPop: () async => false,
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(
            maxHeight: 30.h,
            minWidth: getx.Get.width / 1.2,
          ),
          child: Column(
            children: [
              getx.Obx(() {
                return Text(
                  '${downloadController.downloadProgress.value}${AppStrings.openingWaitingForAWhile}',
                  style: AppTextStyle.poppinsTextStyle16SemiBold(
                    color: AppColors.color4D1877,
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
    Response response = await dio.get(
      url,
      onReceiveProgress: (received, total) {
        downloadController.downloadProgress.value = (((received / total) * 100).round());
        if (received / total == 1) {
          getx.Get.close(0);
        }
      },
      //Received data with List<int>
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    File file = File(savePath);
    var raf = file.openSync(mode: FileMode.write);
    // response.data is List<int> type
    raf.writeFromSync(response.data);
    await raf.close();
    return file.path;
  } catch (e) {
    getx.Get.close(1); // close the download popup
    Fluttertoast.showToast(msg: AppStrings.cannotOpenFile);
  }
  return '';
}

String getYoutubeVideoId(String url, {getFullUrl = false}) {
  RegExp regExp = RegExp(
    r'.*(?:(?:youtu\.be\/|e\/|v\/|vi\/|u\/\w\/|embed\/|shorts\/)|(?:(?:watch)?\?v(?:i)?=|\&v(?:i)?=))([^#\&\?]*).*',
    caseSensitive: false,
    multiLine: false,
  );
  final match = regExp.firstMatch(url)?.group(1); // <- This is the fix
  String str = match ?? '';

  if (getFullUrl) {
    return 'http://youtu.be/$str';
  } else {
    return str;
  }
}

String getThumbUrlFromYoutubeLink({required String videoUrl}) {
  return 'https://i1.ytimg.com/vi/${getYoutubeVideoId(videoUrl)}/mqdefault.jpg';
}
