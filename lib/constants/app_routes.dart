import 'package:get/get.dart';
import 'package:students/view/auth/forgot_password/forgot_password_page1.dart';
import 'package:students/view/auth/forgot_password/forgot_password_page2.dart';
import 'package:students/view/auth/forgot_password/forgot_password_page3.dart';
import 'package:students/view/auth/forgot_password/forgot_password_binding.dart';
import 'package:students/view/auth/help/help_binding.dart';
import 'package:students/view/auth/help/help_page.dart';
import 'package:students/view/auth/login/login_binding.dart';
import 'package:students/view/auth/login/login_page.dart';
import 'package:students/view/auth/login/dynamic_link_login.dart';
import 'package:students/view/auth/registration/registration_binding.dart';
import 'package:students/view/auth/registration/registration_page1.dart';
import 'package:students/view/auth/registration/registration_page2.dart';
import 'package:students/view/bottom_navigation_bar/bottom_navigation.dart';
import 'package:students/view/bottom_navigation_bar/bottom_navigation_binding.dart';
import 'package:students/view/chapter/chapter_list.dart';
import 'package:students/view/chapter/chapter_list_binding.dart';
import 'package:students/view/chapter_details/chapter_details_page.dart';
import 'package:students/view/event/event_detail/event_detail_binding.dart';
import 'package:students/view/event/event_detail/event_detail_page.dart';
import 'package:students/view/event/event_notification/event_notification_bindings.dart';
import 'package:students/view/event/event_notification/event_notification_page.dart';
import 'package:students/view/home/home_binding.dart';
import 'package:students/view/home/home_page.dart';
import 'package:students/view/leaderboard/leader_board.dart';
import 'package:students/view/leaderboard/leader_board_binding.dart';
import 'package:students/view/splash/splash_binding.dart';
import 'package:students/view/splash/splash_page.dart';

/// All routes for app pages are defined here
class AppRoutes {
  static const initial = '/splash_page';
  static const homePage = '/home_page';
  static const loginPage = '/login_page';
  static const forgotPasswordPage = '/forgot_password_page';
  static const forgotPasswordPage2 = '/forgot_password_page2';
  static const forgotPasswordPage3 = '/forgot_password_page3';
  static const helpPage = '/help_page';
  static const registrationPage1 = '/registration_page1';
  static const registrationPage2 = '/registration_page2';
  static const dynamicLinkLogin = '/dynamic_link_login';
  static const bottomMainPage = '/bottom_main_page';
  static const chapterListPage = '/chapter_list';
  static const chapterDetailsPage = '/chapter_details_page';
  static const eventDetailPage = '/event_details';
  static const eventNotificationPage = '/event_notification';
  static const leaderBoardPage = '/leader_board';

  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.initial,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.homePage,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.loginPage,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.dynamicLinkLogin,
      page: () => DynamiLinkLogin(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPasswordPage,
      page: () => const ForgotPasswordPage1(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPasswordPage2,
      page: () => ForgotPasswordPage2(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPasswordPage3,
      page: () => ForgotPasswordPage3(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.helpPage,
      page: () => HelpPage(),
      binding: HelpBinding(),
    ),
    GetPage(
      name: AppRoutes.registrationPage1,
      page: () => RegistrationPage1(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: AppRoutes.registrationPage2,
      page: () => RegistrationPage2(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: AppRoutes.bottomMainPage,
      page: () => BottomNavigationPage(),
      transition: Transition.fadeIn,
      binding: BottomNavigationBinding(),
    ),
    GetPage(
      name: AppRoutes.chapterListPage,
      page: () => ChapterList(),
      transition: Transition.fadeIn,
      binding: ChapterListBinding(),
    ),
    GetPage(
      name: AppRoutes.eventDetailPage,
      page: () => EventDetailPage(),
      transition: Transition.fadeIn,
      binding: EventDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.eventNotificationPage,
      page: () => EventNotificationPage(),
      transition: Transition.fadeIn,
      binding: EventNotificationBinding(),
    ),
    GetPage(
      name: AppRoutes.chapterDetailsPage,
      page: () => ChapterDetailsPage(),
      transition: Transition.fadeIn,
      binding: ChapterListBinding(),
    ),
    GetPage(
      name: AppRoutes.leaderBoardPage,
      page: () => LeaderBoardPage(),
      transition: Transition.fadeIn,
      binding: LeaderBoardBinding(),
    ),
  ];
}
