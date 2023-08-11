import 'package:get/get.dart';
import 'package:students/view/event/event_list/event_controller.dart';

class EventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EventController());
  }
}
