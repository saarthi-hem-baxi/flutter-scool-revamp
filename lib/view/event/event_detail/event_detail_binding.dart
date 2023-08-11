import 'package:get/get.dart';
import 'package:students/view/event/event_detail/event_detail_controller.dart';

class EventDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EventDetailController());
  }
}
