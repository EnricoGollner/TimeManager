import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:working_time_manager/app/pages/main_page.dart';
import 'package:working_time_manager/core/theme/theme_provider.dart';

class WorkingTimeApp extends StatelessWidget {
  const WorkingTimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('pt', 'BR'),
            Locale('en', 'US'),
          ],
          theme: Provider.of<ThemeProvider>(context).themeData,
          home: const MainPage(),
        );
      },
    );
  }
}
