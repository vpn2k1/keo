import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../l10n/app_localizations.dart';
import '../ui/keo_theme.dart';
import 'keo_routes.dart';

class KeoApp extends StatefulWidget {
  const KeoApp({super.key, this.initialLocation = KeoRoutes.home});

  final String initialLocation;

  @override
  State<KeoApp> createState() => _KeoAppState();
}

class _KeoAppState extends State<KeoApp> {
  late final GoRouter _router = createKeoRouter(
    initialLocation: widget.initialLocation,
  );

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        // Mẫu thiết kế 9:16 như bộ art trong assets/images.
        designSize: const Size(390, 844),
        minTextAdapt: true,
        builder: (context, _) => MaterialApp.router(
          onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
          debugShowCheckedModeBanner: false,
          theme: keoTheme(),
          locale: const Locale('vi'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: _router,
        ),
      );
}
