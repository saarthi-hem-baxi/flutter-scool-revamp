import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class EventDetailController extends GetxController with GetTickerProviderStateMixin {
  List<String> imageList = [
    'https://randomuser.me/api/portraits/women/41.jpg',
    'https://randomuser.me/api/portraits/women/42.jpg',
    'https://randomuser.me/api/portraits/women/43.jpg',
  ];
  List<String> galleryList = [
    'https://thumbs.dreamstime.com/b/hotel-meeting-event-room-empty-conference-provides-space-business-meetings-conferences-speakers-events-tables-chairs-65381361.jpg',
    'https://thumbs.dreamstime.com/b/hotel-meeting-event-room-empty-conference-provides-space-business-meetings-conferences-speakers-events-tables-chairs-65381361.jpg',
    'https://thumbs.dreamstime.com/b/hotel-meeting-event-room-empty-conference-provides-space-business-meetings-conferences-speakers-events-tables-chairs-65381361.jpg',
    'https://thumbs.dreamstime.com/b/hotel-meeting-event-room-empty-conference-provides-space-business-meetings-conferences-speakers-events-tables-chairs-65381361.jpg',
    'https://thumbs.dreamstime.com/b/hotel-meeting-event-room-empty-conference-provides-space-business-meetings-conferences-speakers-events-tables-chairs-65381361.jpg'
  ];

  TabController? tabController;
  late AutoScrollController _scrollController;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionListener = ItemPositionsListener.create();
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    _scrollController = AutoScrollController(
      viewportBoundaryGetter: () => Rect.fromLTRB(
        0,
        0,
        0,
        Get.mediaQuery.padding.bottom,
      ),
      axis: Axis.vertical,
    );
    _scrollController.addListener(() {
      final double maxScroll = _scrollController.position.maxScrollExtent;
      final double currentScroll = _scrollController.position.pixels;
      final double delta = maxScroll / (3 - 1);
      final int tabIndex = (currentScroll / delta).round();
      tabController?.animateTo(tabIndex);
    });
    super.onInit();
  }
}
