class NotificationList {
  final String title;
  final String receivedBy;
  final bool isReaded;
  final String description;
  final String dateTime;
  NotificationList({
    required this.dateTime,
    required this.description,
    required this.isReaded,
    required this.receivedBy,
    required this.title,
  });
}

class NotificationData {
  final String day;
  final List<NotificationList> notificationlist;
  NotificationData({
    required this.day,
    required this.notificationlist,
  });
}
