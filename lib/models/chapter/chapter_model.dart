class ChapterListModel {
  final List<Quarters>? quarters;

  ChapterListModel({
    this.quarters,
  });

  ChapterListModel.fromJson(Map<String, dynamic> json)
      : quarters = (json['quarters'] as List?)?.map((dynamic e) => Quarters.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {'quarters': quarters?.map((e) => e.toJson()).toList()};
}

class Quarters {
  final String? title;
  final List<Months>? months;

  Quarters({
    this.title,
    this.months,
  });

  Quarters.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String?,
        months = (json['months'] as List?)?.map((dynamic e) => Months.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {'title': title, 'months': months?.map((e) => e.toJson()).toList()};
}

class Months {
  final String? month;
  final List<Chapters>? chapters;

  Months({
    this.month,
    this.chapters,
  });

  Months.fromJson(Map<String, dynamic> json)
      : month = json['month'] as String?,
        chapters = (json['chapters'] as List?)?.map((dynamic e) => Chapters.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {'month': month, 'chapters': chapters?.map((e) => e.toJson()).toList()};
}

class Chapters {
  final String? chapterName;
  final int? obtainMark;
  final int? totalMark;
  final int? orderNumber;
  final String? bookId;
  final String? chapterId;
  final String? bookName;
  final bool? conceptMap;

  Chapters({
    this.chapterName,
    this.obtainMark,
    this.totalMark,
    this.orderNumber,
    this.bookId,
    this.chapterId,
    this.bookName,
    this.conceptMap,
  });

  Chapters.fromJson(Map<String, dynamic> json)
      : chapterName = json['chapter_name'] as String?,
        obtainMark = json['obtain_mark'] as int?,
        totalMark = json['total_mark'] as int?,
        orderNumber = json['orderNumber'] as int?,
        bookId = json['bookId'] as String?,
        chapterId = json['chapterId'] as String?,
        conceptMap = json['conceptMap'] as bool?,
        bookName = json['bookName'] as String?;

  Map<String, dynamic> toJson() => {
        'chapter_name': chapterName,
        'obtain_mark': obtainMark,
        'total_mark': totalMark,
        'orderNumber': orderNumber,
        'bookId': bookId,
        'chapterId': chapterId,
        'bookName': bookName,
        'conceptMap': conceptMap,
      };
}
