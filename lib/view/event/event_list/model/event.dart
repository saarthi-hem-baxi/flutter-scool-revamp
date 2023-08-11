import 'package:students/constants/app_enums.dart';

class Event {
  final String eventName;
  final String eventImage;
  final String eventDate;
  final String eventTime;
  final String eventLikes;
  final bool isLive;
  final String city;
  final String eventViews;
  final String eventDescription;
  final bool canDownloadCertificate;
  final EventType eventType;

  Event({
    required this.eventDate,
    required this.eventDescription,
    required this.eventImage,
    required this.eventLikes,
    required this.city,
    required this.eventTime,
    required this.isLive,
    required this.eventName,
    required this.eventViews,
    this.canDownloadCertificate = false,
    required this.eventType,
  });
}

class CompletedEvent {
  final String eventName;
  final String eventImage;
  final String eventDate;
  final String eventTime;
  final String eventLikes;
  final bool canDownload;
  final bool isOnline;
  final String city;
  final String eventViews;
  final String eventDescription;

  CompletedEvent({
    required this.eventDate,
    required this.canDownload,
    required this.eventDescription,
    required this.eventImage,
    required this.eventLikes,
    required this.isOnline,
    required this.city,
    required this.eventTime,
    required this.eventName,
    required this.eventViews,
  });
}
