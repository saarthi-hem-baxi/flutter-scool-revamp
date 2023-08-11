class CommunicationFeedModel {
  final List<Data>? data;

  CommunicationFeedModel({
    this.data,
  });

  CommunicationFeedModel.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {'data': data?.map((e) => e.toJson()).toList()};
}

class Data {
  final String? date;
  final List<Messages>? messages;

  Data({
    this.date,
    this.messages,
  });

  Data.fromJson(Map<String, dynamic> json)
      : date = json['date'] as String?,
        messages = (json['messages'] as List?)?.map((dynamic e) => Messages.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {'date': date, 'messages': messages?.map((e) => e.toJson()).toList()};
}

class Messages {
  final String? userName;
  final String? message;
  final String? time;
  final List<Media>? media;

  Messages({
    this.userName,
    this.message,
    this.time,
    this.media,
  });

  Messages.fromJson(Map<String, dynamic> json)
      : userName = json['user_name'] as String?,
        message = json['message'] as String?,
        time = json['time'] as String?,
        media = (json['media'] as List?)?.map((dynamic e) => Media.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {'user_name': userName, 'message': message, 'time': time, 'media': media?.map((e) => e.toJson()).toList()};
}

class Media {
  final String? mediaType;
  final String? medialUrl;
  final String? thumbUrl;

  Media({
    this.mediaType,
    this.medialUrl,
    this.thumbUrl,
  });

  Media.fromJson(Map<String, dynamic> json)
      : mediaType = json['media_type'] as String?,
        medialUrl = json['medial_url'] as String?,
        thumbUrl = json['thumb_url'] as String?;

  Map<String, dynamic> toJson() => {'media_type': mediaType, 'medial_url': medialUrl, 'thumb_url': thumbUrl};
}
