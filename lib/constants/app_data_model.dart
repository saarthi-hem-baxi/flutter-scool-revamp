/// used to pass arguments
class AppDataModel {
  int? id;
  String? email;
  String? schoolId;
  String? subjectTitle;
  String? sectionId;
  String? subjectId;
  String? classId;
  String? chapterTitle;
  String? chapterId;
  String? bookId;
  bool? isFromDynamicLink = false;
  bool? isFromPasswordReset = false;
  String? resetToken = '';
  bool? isSingleSchoolUser = false;
  bool? isBackButtonEnabled = true;
  bool? isFromAddSchoolBtn = false;
  Map? userInputLoginData;
  bool? isFromLoginAddSchool = false;

  AppDataModel({
    this.id,
    this.email,
    this.schoolId,
    this.subjectTitle,
    this.sectionId,
    this.subjectId,
    this.classId,
    this.chapterTitle,
    this.chapterId,
    this.bookId,
    this.isFromDynamicLink,
    this.isFromPasswordReset,
    this.resetToken,
    this.isSingleSchoolUser,
    this.isBackButtonEnabled,
    this.isFromAddSchoolBtn,
    this.userInputLoginData,
    this.isFromLoginAddSchool,
  });
}
