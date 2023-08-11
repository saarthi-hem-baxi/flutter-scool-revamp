import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:students/constants/app_class.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_routes.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/app_theme.dart';
import 'package:students/helpers/connectivity_manager.dart';
import 'package:students/helpers/firebase/firebase_services.dart';
import 'package:students/helpers/utils.dart';
import 'package:students/widgets/loading_spinner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// init firebase services
  FirebaseServices.instance;

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Utils.setStatusBarColor();
  await GetStorage.init();
  await dotenv.load();
  ConnectivityManager().setConnectivityListener();
  runApp(const MyApp());
  ConnectivityManager().appInitCheckStatus();
  Get.config(defaultTransition: Transition.fadeIn, defaultDurationTransition: const Duration(milliseconds: 100));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        // For Android.
        // Use [light] for white status bar and [dark] for black status bar.
        statusBarIconBrightness: Brightness.dark,
        // For iOS.
        // Use [dark] for white status bar and [light] for black status bar.
        statusBarBrightness: Brightness.light,
        statusBarColor: AppColors.colorWhite,
      ),
      child: ScreenUtilInit(
        designSize: AppTheme.designSize,
        builder: (context, widget) {
          return GetMaterialApp(
            enableLog: true,
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            theme: ThemeData(
              fontFamily: AppTextStyle.poppinsRegularFont,
              fontFamilyFallback: [
                AppTextStyle.nunitoRegularFont,
                AppTextStyle.readexProRegularFont,
              ],
              primarySwatch: AppColors.primaryPalette,
              scaffoldBackgroundColor: AppColors.colorWhite,
            ),
            builder: (context, widget) => ColoredBox(
              color: AppColors.colorWhite,
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), child: getMainAppViewBuilder(context, widget)),
              ),
            ),
            getPages: AppRoutes.pages,
            initialRoute: AppRoutes.initial,
            locale: Get.deviceLocale,
            fallbackLocale: const Locale('en'),
          );
        },
      ),
    );
  }

  /// Create main app view builder
  Widget getMainAppViewBuilder(BuildContext context, Widget? widget) {
    return Stack(
      children: [
        Obx(() {
          return IgnorePointer(
            ignoring: AppClass().isShowLoading.isTrue,
            child: Stack(
              children: [
                widget ?? const Offstage(),
                if (AppClass().isShowLoading.isTrue)
                  ColoredBox(
                    color: AppColors.colorWhite.withOpacity(0.3),
                    child: Center(
                      child: LoadingSpinner(),
                    ),
                  )
              ],
            ),
          );
        })
      ],
    );
  }
}
