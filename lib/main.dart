import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:live_tracking_demo/utils/navigation_service.dart';
import 'package:live_tracking_demo/view/team/team_dashboard_screen.dart';
import 'package:live_tracking_demo/viewModels/team_view_model.dart';
import 'package:provider/provider.dart';

import 'common/colors.dart';
import 'injection_container.dart' as di;
import 'route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: MyColors.white, // navigation bar color
  ));
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => di.serviceLocator<TeamViewModel>(),
        ),
      ],
      child: Consumer<TeamViewModel>(
        builder: (context, settings, child) {
          return MaterialApp(
            navigatorKey: NavigationService.navigatorKey,
            title: 'AW Rostamani',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RouteGenerator.generateRoute,
            onUnknownRoute: (settings) => MaterialPageRoute(
              builder: (_) => const TeamDashboardScreen(),
              settings: settings,
            ),
          );
        },
      ),
    );
  }
}
