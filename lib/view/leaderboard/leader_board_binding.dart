import 'package:get/get.dart';
import 'package:students/view/leaderboard/leader_board_controller.dart';

class LeaderBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LeaderBoardController());
  }
}
