import 'package:get/get.dart';
import 'package:students/view/chapter/chapter_controller.dart';
import 'package:students/view/chapter_details/chapter_details_controller.dart';

class ChapterListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChapterController());
    Get.lazyPut(() => ChapterDetailsController());
  }
}
