import 'package:flutter/material.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_image_assets.dart';
import 'package:students/view/bottom_navigation_bar/bottom_bar.dart';
import 'package:students/view/communication/communication_feed.dart';
import 'package:students/view/event/event_list/event_page.dart';
import 'package:students/view/home/home_page.dart';
import 'package:students/widgets/status_color_manager.dart';

class BottomNavPage {
  final String label;
  final Widget widget;
  // final Color color;
  final String activeIcon;
  final String inactiveIcon;

  BottomNavPage({
    required this.label,
    required this.widget,
    // required this.color,
    required this.activeIcon,
    required this.inactiveIcon,
  });
}

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key, this.selectedIndex = 0}) : super(key: key);
  final int selectedIndex;

  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> with WidgetsBindingObserver {
  int _selectedIndex = 0;

  final List _pages = [
    BottomNavPage(
      label: 'Dashboard',
      widget: HomePage(),
      activeIcon: AppImageAssets.bottombarHome,
      inactiveIcon: AppImageAssets.bottombarInActiveHome,
    ),
    BottomNavPage(
      label: 'Communication',
      widget: CommunicationFeed(),
      activeIcon: AppImageAssets.bottombarCommunication,
      inactiveIcon: AppImageAssets.bottombarInActiveCommunication,
    ),
    BottomNavPage(
      label: 'Event',
      widget: EventPage(),
      activeIcon: AppImageAssets.bottombarCommunication,
      inactiveIcon: AppImageAssets.bottombarInActiveCommunication,
    ),

    // const Event(),
    // const CommunicationFeed(),
    // const MenuScreenPage(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    //TODO : socket connection
    // init all socket
    Future.delayed(Duration.zero, () {
      //TODO : socket connection
      // initSocketConnectionForApp();
    });

    setState(() {
      _selectedIndex = widget.selectedIndex;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        //TODO : socket connection
        // connectToAnalyticsSocketServer();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        //TODO : socket connection
        // disconnectAnalyticsSocket();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatusBarColorManager(
      color: AppColors.navyBlueDarkExtra,
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        body: _pages[_selectedIndex].widget,
        bottomNavigationBar: BottomBar(
          onBottomTabSelected: (tab) {
            _onItemTapped(tab.index);
          },
        ),
      ),
    );
  }
}
