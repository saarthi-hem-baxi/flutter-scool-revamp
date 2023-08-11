import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:students/firebase_options.dart';
import 'package:students/helpers/firebase/firebase_messging.dart';

class FirebaseServices {
  FirebaseServices() {
    _init();
  }

  static FirebaseServices get instance => FirebaseServices();

  void _init() async {
    // initializing firebase app
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // initializing firebase analytics
    FirebaseAnalytics.instance;

    // initializing crashalytics
    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    } else {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    }

    // initializing firebase messaging
    FirebaseMessagingHandler.instance;

    /// initializing firebase dynamic links
    FirebaseDynamicLinks.instance;

    ///
    ///
    ///
  }
}
