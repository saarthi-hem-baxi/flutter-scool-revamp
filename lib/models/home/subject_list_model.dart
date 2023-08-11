import 'dart:ui';

class SubjectListModel {
  final String? subjectId;
  final String? classId;
  final String? sectionId;
  final String name;
  final Color bgColor;
  final Color bubbleColor;
  final String emoji;
  final String gif;

  SubjectListModel({
    required this.name,
    required this.bgColor,
    required this.bubbleColor,
    required this.emoji,
    required this.gif,
    this.subjectId,
    this.classId,
    this.sectionId,
  });
}
