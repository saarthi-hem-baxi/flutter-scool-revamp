import 'package:get/get.dart';
import 'package:students/view/event/event_notification/event_notification_controller.dart';

class EventNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EventNotificationController());
  }
}
