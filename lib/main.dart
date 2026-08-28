import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'components/touch_indicator/touch_indicator_widget.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const TouchIndicator(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      initialLocation: AssetDashboardWidget.routePath,
      routes: [
        GoRoute(
          name: AssetDashboardWidget.routeName,
          path: AssetDashboardWidget.routePath,
          builder: (context, state) => const AssetDashboardWidget(),
        ),
        GoRoute(
          name: IssueReportWidget.routeName,
          path: IssueReportWidget.routePath,
          builder: (context, state) => const IssueReportWidget(),
        ),
        GoRoute(
          name: AIAnalysisResultWidget.routeName,
          path: AIAnalysisResultWidget.routePath,
          builder: (context, state) => const AIAnalysisResultWidget(),
        ),
        GoRoute(
          name: DispatchConfirmationWidget.routeName,
          path: DispatchConfirmationWidget.routePath,
          builder: (context, state) => const DispatchConfirmationWidget(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ServiceOps AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF1A237E),
        scaffoldBackgroundColor: const Color(0xFFF4F6F9),
        textTheme: GoogleFonts.robotoTextTheme(),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
