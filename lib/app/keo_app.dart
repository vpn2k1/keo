import 'package:flutter/material.dart';

import '../ui/keo_theme.dart';
import 'keo_routes.dart';

class KeoApp extends StatelessWidget {
  const KeoApp({super.key, this.initialRoute = KeoRoutes.splash});

  final String initialRoute;

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'KEO - Vượt Phòng Tuyến',
        debugShowCheckedModeBanner: false,
        theme: keoTheme(),
        initialRoute: initialRoute,
        routes: keoRoutes,
        onGenerateRoute: keoGameRoute,
      );
}
