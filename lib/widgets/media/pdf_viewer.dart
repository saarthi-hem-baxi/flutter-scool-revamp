// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:disk_space/disk_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/widgets/loading_spinner.dart';
import 'package:students/widgets/media/loading/loading_sheet.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CustomPDFViewer extends StatefulWidget {
  const CustomPDFViewer({Key? key, required this.title, required this.pdfUrl, this.pdfFile, this.isFileForm = false, this.insidePage = false})
      : super(key: key);

  final String title;
  final String pdfUrl;
  final File? pdfFile;
  final bool isFileForm;
  final bool insidePage;

  @override
  _CustomPDFViewerState createState() => _CustomPDFViewerState();
}

class _CustomPDFViewerState extends State<CustomPDFViewer> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  var isFromLocal = false;
  String pdfUrl = '';
  var isCheckComplete = false;

  @override
  void initState() {
    super.initState();
    pdfUrl = widget.pdfUrl;
    if (widget.isFileForm) {
      isCheckComplete = true;
      setState(() {});
    } else {
      _savePdf(pdfUrl);
    }
    Future.delayed(Duration.zero, () {
      showLoadingSheet();
    });
  }

  void showLoadingSheet() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const [
              SizedBox(
                height: 8.0,
              ),
              LoadingSheetWidget()
            ],
          ),
        ),
      ),
    );
  }

  void hideLoadingSheet() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: !widget.insidePage
            ? PreferredSize(
                preferredSize: Size.fromHeight(40.h),
                child: AppBar(
                  automaticallyImplyLeading: false,
                  title: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 7.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.w),
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: AppColors.color4D1877,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Flexible(
                        child: Text(
                          widget.title,
                          style: AppTextStyle.nunitoTextStyle24SemiBold(color: AppColors.color4D1877),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
              )
            : null,
        body: isCheckComplete
            ? widget.isFileForm || isFromLocal
                ? SfPdfViewer.file(
                    widget.isFileForm ? widget.pdfFile ?? File('') : File(pdfUrl),
                    key: _pdfViewerKey,
                    scrollDirection: PdfScrollDirection.vertical,
                    onDocumentLoaded: (v) {
                      hideLoadingSheet();
                    },
                  )
                : SfPdfViewer.network(
                    pdfUrl,
                    key: _pdfViewerKey,
                    scrollDirection: PdfScrollDirection.vertical,
                    onDocumentLoaded: (v) {
                      hideLoadingSheet();
                    },
                  )
            : const Center(
                child: LoadingSpinner(),
              ),
      ),
    );
  }

  Future _savePdf(String url) async {
    http.Response r = await http.head(Uri.parse(url));
    var urlPdfSize = double.parse(r.headers['content-length'].toString()) / (1024 * 1024);
    var appDocDir = await getTemporaryDirectory();
    String fullPath = "${appDocDir.path}/${url.split("/").isNotEmpty ? url.split("/")[url.split("/").length - 1].replaceAll('%20', '') : ""}";
    bool fileExists = await File(fullPath).exists();
    if (fileExists && urlPdfSize == File(fullPath).lengthSync() / (1024 * 1024)) {}
    if (!fileExists) {
      try {
        if (await getDiskSpaceInfo(urlPdfSize)) {
          setState(() {
            isFromLocal = false;
            pdfUrl = url;
            isCheckComplete = true;
          });
          await Dio().download(url, fullPath, onReceiveProgress: (received, total) {
            if (total != -1) {}
          });
        } else {
          setState(() {
            isFromLocal = false;
            pdfUrl = url;
            isCheckComplete = true;
          });
        }
        // ignore: empty_catches
      } on DioError {}
    } else {
      if (urlPdfSize == File(fullPath).lengthSync() / (1024 * 1024)) {
        setState(() {
          isFromLocal = true;
          pdfUrl = fullPath;
          isCheckComplete = true;
        });
      } else {
        setState(() {
          isFromLocal = false;
          pdfUrl = url;
          isCheckComplete = true;
        });
      }
    }
  }

  Future<bool> getDiskSpaceInfo(double urlVideoSize) async {
    var space = await DiskSpace.getFreeDiskSpace;
    if (urlVideoSize < space!) {
      return true;
    } else {
      return false;
    }
  }
}
