import 'package:flutter_dotenv/flutter_dotenv.dart';

class APIUrls {
  late String lmsUrl;
  late String weblmsUrl;
  late String lmsStudentUrl;
  late String authUrl;
  late String schoolAPIUrl;
  late String registraionUrl;
  late String lmsSchoolUrl;

  APIUrls() {
    lmsUrl = dotenv.env['LMS_API_URL'] ?? '';
    weblmsUrl = dotenv.env['WEB_LMS_API_URL'] ?? '';
    lmsSchoolUrl = lmsUrl + 'schools/';
    lmsStudentUrl = lmsUrl + 'student/';
    authUrl = lmsStudentUrl + 'auth/';
    schoolAPIUrl = dotenv.env['SCHOOL_API_URL'] ?? '';
    registraionUrl = schoolAPIUrl + 'registration/';
  }
}
