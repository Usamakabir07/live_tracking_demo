import 'package:flutter/material.dart';
import 'package:live_tracking_demo/view/team/team_dashboard_screen.dart';
import 'package:live_tracking_demo/view/team/widgets/vendor_tracking_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(
    RouteSettings settings,
  ) {
    final Widget view;

    switch (settings.name) {
      case TeamDashboardScreen.routeName:
        view = const TeamDashboardScreen();
        break;
      case VendorTrackingScreen.routeName:
        view = const VendorTrackingScreen();
        break;
      default:
        view = const TeamDashboardScreen();
    }
    return MaterialPageRoute(builder: (_) => view, settings: settings);
  }
}
