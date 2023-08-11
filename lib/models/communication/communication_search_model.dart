class CommunicationSearchModel {
  final List<Photos>? photos;
  final List<Videos>? videos;
  final List<Documents>? documents;
  final List<Links>? links;
  final List<Subjects>? subjects;

  CommunicationSearchModel({
    this.photos,
    this.videos,
    this.documents,
    this.links,
    this.subjects,
  });

  CommunicationSearchModel.fromJson(Map<String, dynamic> json)
      : photos = (json['photos'] as List?)?.map((dynamic e) => Photos.fromJson(e as Map<String, dynamic>)).toList(),
        videos = (json['videos'] as List?)?.map((dynamic e) => Videos.fromJson(e as Map<String, dynamic>)).toList(),
        documents = (json['documents'] as List?)?.map((dynamic e) => Documents.fromJson(e as Map<String, dynamic>)).toList(),
        links = (json['links'] as List?)?.map((dynamic e) => Links.fromJson(e as Map<String, dynamic>)).toList(),
        subjects = (json['subjects'] as List?)?.map((dynamic e) => Subjects.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'photos': photos?.map((e) => e.toJson()).toList(),
        'videos': videos?.map((e) => e.toJson()).toList(),
        'documents': documents?.map((e) => e.toJson()).toList(),
        'links': links?.map((e) => e.toJson()).toList(),
        'subjects': subjects?.map((e) => e.toJson()).toList()
      };
}

class Photos {
  final String? date;
  final String? time;
  final String? name;
  final String? description;
  final List<PhotosMedia>? photosMedia;

  Photos({
    this.date,
    this.time,
    this.name,
    this.description,
    this.photosMedia,
  });

  Photos.fromJson(Map<String, dynamic> json)
      : date = json['date'] as String?,
        time = json['time'] as String?,
        name = json['name'] as String?,
        description = json['description'] as String?,
        photosMedia = (json['photos_media'] as List?)?.map((dynamic e) => PhotosMedia.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() =>
      {'date': date, 'time': time, 'name': name, 'description': description, 'photos_media': photosMedia?.map((e) => e.toJson()).toList()};
}

class PhotosMedia {
  final String? mediaType;
  final String? medialUrl;
  final String? thumbUrl;

  PhotosMedia({
    this.mediaType,
    this.medialUrl,
    this.thumbUrl,
  });

  PhotosMedia.fromJson(Map<String, dynamic> json)
      : mediaType = json['media_type'] as String?,
        medialUrl = json['medial_url'] as String?,
        thumbUrl = json['thumb_url'] as String?;

  Map<String, dynamic> toJson() => {'media_type': mediaType, 'medial_url': medialUrl, 'thumb_url': thumbUrl};
}

class Videos {
  final String? date;
  final String? time;
  final String? name;
  final String? description;
  final List<VideosMedia>? videosMedia;

  Videos({
    this.date,
    this.time,
    this.name,
    this.description,
    this.videosMedia,
  });

  Videos.fromJson(Map<String, dynamic> json)
      : date = json['date'] as String?,
        time = json['time'] as String?,
        name = json['name'] as String?,
        description = json['description'] as String?,
        videosMedia = (json['videos_media'] as List?)?.map((dynamic e) => VideosMedia.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() =>
      {'date': date, 'time': time, 'name': name, 'description': description, 'videos_media': videosMedia?.map((e) => e.toJson()).toList()};
}

class VideosMedia {
  final String? mediaType;
  final String? medialUrl;
  final String? thumbUrl;

  VideosMedia({
    this.mediaType,
    this.medialUrl,
    this.thumbUrl,
  });

  VideosMedia.fromJson(Map<String, dynamic> json)
      : mediaType = json['media_type'] as String?,
        medialUrl = json['medial_url'] as String?,
        thumbUrl = json['thumb_url'] as String?;

  Map<String, dynamic> toJson() => {'media_type': mediaType, 'medial_url': medialUrl, 'thumb_url': thumbUrl};
}

class Documents {
  final String? date;
  final String? time;
  final String? name;
  final String? description;
  final List<DocumentsMedia>? documentsMedia;

  Documents({
    this.date,
    this.time,
    this.name,
    this.description,
    this.documentsMedia,
  });

  Documents.fromJson(Map<String, dynamic> json)
      : date = json['date'] as String?,
        time = json['time'] as String?,
        name = json['name'] as String?,
        description = json['description'] as String?,
        documentsMedia = (json['documents_media'] as List?)?.map((dynamic e) => DocumentsMedia.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() =>
      {'date': date, 'time': time, 'name': name, 'description': description, 'documents_media': documentsMedia?.map((e) => e.toJson()).toList()};
}

class DocumentsMedia {
  final String? mediaType;
  final String? medialUrl;
  final String? thumbUrl;

  DocumentsMedia({
    this.mediaType,
    this.medialUrl,
    this.thumbUrl,
  });

  DocumentsMedia.fromJson(Map<String, dynamic> json)
      : mediaType = json['media_type'] as String?,
        medialUrl = json['medial_url'] as String?,
        thumbUrl = json['thumb_url'] as String?;

  Map<String, dynamic> toJson() => {'media_type': mediaType, 'medial_url': medialUrl, 'thumb_url': thumbUrl};
}

class Links {
  final String? date;
  final String? time;
  final String? name;
  final String? description;
  final List<LinksMedia>? linksMedia;

  Links({
    this.date,
    this.time,
    this.name,
    this.description,
    this.linksMedia,
  });

  Links.fromJson(Map<String, dynamic> json)
      : date = json['date'] as String?,
        time = json['time'] as String?,
        name = json['name'] as String?,
        description = json['description'] as String?,
        linksMedia = (json['links_media'] as List?)?.map((dynamic e) => LinksMedia.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() =>
      {'date': date, 'time': time, 'name': name, 'description': description, 'links_media': linksMedia?.map((e) => e.toJson()).toList()};
}

class LinksMedia {
  final String? mediaType;
  final String? medialUrl;
  final String? thumbUrl;

  LinksMedia({
    this.mediaType,
    this.medialUrl,
    this.thumbUrl,
  });

  LinksMedia.fromJson(Map<String, dynamic> json)
      : mediaType = json['media_type'] as String?,
        medialUrl = json['medial_url'] as String?,
        thumbUrl = json['thumb_url'] as String?;

  Map<String, dynamic> toJson() => {'media_type': mediaType, 'medial_url': medialUrl, 'thumb_url': thumbUrl};
}

class Subjects {
  final String? date;
  final List<Messages>? messages;

  Subjects({
    this.date,
    this.messages,
  });

  Subjects.fromJson(Map<String, dynamic> json)
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
