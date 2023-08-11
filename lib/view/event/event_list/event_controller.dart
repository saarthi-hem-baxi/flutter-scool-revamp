import 'package:get/get.dart';
import 'package:students/constants/app_enums.dart';
import 'package:students/view/event/event_list/model/days_filter.dart';
import 'package:students/view/event/event_list/model/event.dart';

class EventController extends GetxController with GetTickerProviderStateMixin {
  RxInt currentIndex = 0.obs;
  RxBool isCertificateVisible = false.obs;

  RxList<DaysFilter> daysfilter = [
    DaysFilter(
      dayName: 'Today',
      isChecked: false,
    ),
    DaysFilter(
      dayName: 'Tomorrow',
      isChecked: false,
    ),
    DaysFilter(
      dayName: 'This Week',
      isChecked: false,
    ),
    DaysFilter(
      dayName: 'This Month',
      isChecked: false,
    ),
  ].obs;
  RxList<DaysFilter> modesFilter = [
    DaysFilter(
      dayName: 'Online',
      isChecked: false,
    ),
    DaysFilter(
      dayName: 'Offline',
      isChecked: false,
    ),
  ].obs;

  List<Event> eventsData = [
    Event(
      eventDate: '13 may 2023',
      isLive: true,
      city: 'Vadodara',
      eventDescription:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,um is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the indu",
      eventImage:
          'https://images.unsplash.com/photo-1531058020387-3be344556be6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80.jpg',
      eventLikes: '845',
      eventTime: '10:30 am',
      eventName: 'Event title name',
      eventViews: '1.5k',
      eventType: EventType.upComing,
    ),
    Event(
      eventDate: '13 may 2023',
      isLive: false,
      city: 'Surat',
      eventDescription:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries",
      eventImage:
          'https://images.unsplash.com/photo-1531058020387-3be344556be6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80.jpg',
      eventLikes: '845',
      eventTime: '10:30 am',
      eventName: 'Event title name',
      eventViews: '1.5k',
      eventType: EventType.upComing,
    ),
    Event(
      eventDate: '13 may 2023',
      city: 'Rajkot',
      isLive: false,
      eventDescription:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries",
      eventImage:
          'https://images.unsplash.com/photo-1531058020387-3be344556be6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80.jpg',
      eventLikes: '845',
      eventTime: '10:30 am',
      eventName: 'Event title name',
      eventViews: '1.5k',
      eventType: EventType.upComing,
    ),
    Event(
      eventDate: '13 may 2023',
      isLive: true,
      city: 'Vadodara',
      eventDescription:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,um is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the indu",
      eventImage:
          'https://images.unsplash.com/photo-1531058020387-3be344556be6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80.jpg',
      eventLikes: '845',
      eventTime: '10:30 am',
      eventName: 'Event title name',
      eventViews: '1.5k',
      eventType: EventType.registered,
    ),
    Event(
      eventDate: '13 may 2023',
      isLive: true,
      city: 'Vadodara',
      eventDescription:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,um is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the indu",
      eventImage:
          'https://images.unsplash.com/photo-1531058020387-3be344556be6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80.jpg',
      eventLikes: '845',
      eventTime: '10:30 am',
      eventName: 'Event title name',
      eventViews: '1.5k',
      eventType: EventType.registered,
    ),
    Event(
      eventDate: '13 may 2023',
      isLive: true,
      city: 'Vadodara',
      eventDescription:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,um is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the indu",
      eventImage:
          'https://images.unsplash.com/photo-1531058020387-3be344556be6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80.jpg',
      eventLikes: '845',
      eventTime: '10:30 am',
      eventName: 'Event title name',
      eventViews: '1.5k',
      eventType: EventType.completed,
    ),
    Event(
      eventDate: '13 may 2023',
      isLive: true,
      city: 'Vadodara',
      eventDescription:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,um is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the indu",
      eventImage:
          'https://images.unsplash.com/photo-1531058020387-3be344556be6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80.jpg',
      eventLikes: '845',
      eventTime: '10:30 am',
      eventName: 'Event title name',
      eventViews: '1.5k',
      eventType: EventType.completed,
    ),
    Event(
      eventDate: '13 may 2023',
      isLive: true,
      city: 'Vadodara',
      eventDescription:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,um is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the indu",
      eventImage:
          'https://images.unsplash.com/photo-1531058020387-3be344556be6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80.jpg',
      eventLikes: '845',
      eventTime: '10:30 am',
      eventName: 'Event title name',
      eventViews: '1.5k',
      eventType: EventType.completed,
    ),
    Event(
        eventDate: '13 may 2023',
        isLive: true,
        city: 'Vadodara',
        eventDescription:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,um is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the indu",
        eventImage:
            'https://images.unsplash.com/photo-1531058020387-3be344556be6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80.jpg',
        eventLikes: '845',
        eventTime: '10:30 am',
        eventName: 'Event title name',
        eventViews: '1.5k',
        eventType: EventType.completed,
        canDownloadCertificate: true),
    Event(
      eventDate: '13 may 2023',
      isLive: true,
      city: 'Vadodara',
      eventDescription:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,um is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the indu",
      eventImage:
          'https://images.unsplash.com/photo-1531058020387-3be344556be6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80.jpg',
      eventLikes: '845',
      eventTime: '10:30 am',
      eventName: 'Event title name',
      eventViews: '1.5k',
      eventType: EventType.completed,
      canDownloadCertificate: true,
    ),
  ];

  /// invoke this method when user tap on clear all button from filter bottom sheet
  void onClearFilter() {
    daysfilter.value = daysfilter.map<DaysFilter>((e) => DaysFilter(dayName: e.dayName, isChecked: false)).toList();
    modesFilter.value = modesFilter.map<DaysFilter>((e) => DaysFilter(dayName: e.dayName, isChecked: false)).toList();
  }
}
