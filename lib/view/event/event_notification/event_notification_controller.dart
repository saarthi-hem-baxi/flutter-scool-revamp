import 'package:get/get.dart';
import 'package:students/view/event/event_notification/models/notification.dart';

class EventNotificationController extends GetxController {
  final List<NotificationData> notificationList = [
    NotificationData(
      day: 'Today',
      notificationlist: [
        NotificationList(
          isReaded: false,
          dateTime: '21st March, 2023 | 9:30 AM',
          description: 'New Event PostedArt & Craft Workshop',
          receivedBy: 'CamlineArt & Craft Workshop,t & Craft Workshopt & Craft Workshopt ',
          title:
              'Art & Craft Workshop,t & Craft Workshopt & Craft Workshopt & Craft Workshopt & Craft Workshopt & Craft Workshopt & Craft Workshopt & Craft Workshopt & Craft Workshopt & Craft Workshopt & Craft Workshop',
        ),
        NotificationList(
          isReaded: true,
          dateTime: '21st March, 2023 | 9:30 AM',
          description: 'New Event PostedArt & Craft Workshop',
          receivedBy: 'Camline',
          title: 'Art & Craft Workshop',
        ),
        NotificationList(
          isReaded: true,
          dateTime: '21st March, 2023 | 9:30 AM',
          description: 'New Event PostedArt & Craft Workshop',
          receivedBy: 'Camline',
          title: 'Art & Craft Workshop',
        ),
        NotificationList(
          isReaded: true,
          dateTime: '21st March, 2023 | 9:30 AM',
          description: 'New Event PostedArt & Craft Workshop',
          receivedBy: 'Camline',
          title: 'Art & Craft Workshop',
        ),
      ],
    ),
    NotificationData(
      day: 'Yesterday',
      notificationlist: [
        NotificationList(
          isReaded: true,
          dateTime: '21st March, 2023 | 9:30 AM',
          description: 'New Event PostedArt & Craft Workshop',
          receivedBy: 'Camline',
          title: 'Art & Craft Workshop',
        ),
        NotificationList(
          isReaded: true,
          dateTime: '21st March, 2023 | 9:30 AM',
          description: 'New Event PostedArt & Craft Workshop',
          receivedBy: 'Camline',
          title: 'Art & Craft Workshop',
        ),
        NotificationList(
          isReaded: true,
          dateTime: '21st March, 2023 | 9:30 AM',
          description: 'New Event PostedArt & Craft Workshop',
          receivedBy: 'Camline',
          title: 'Art & Craft Workshop',
        ),
        NotificationList(
          isReaded: true,
          dateTime: '21st March, 2023 | 9:30 AM',
          description: 'New Event PostedArt & Craft Workshop',
          receivedBy: 'Camline',
          title: 'Art & Craft Workshop',
        ),
      ],
    ),
  ];
}
