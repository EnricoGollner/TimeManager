import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_time_manager/app/controller/working_time_controller.dart';
import 'package:working_time_manager/app/main_app.dart';
import 'package:working_time_manager/core/theme/theme_provider.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // Initializing Database
  // await WorkingTimeRepository.initialize(); //TODO - IMPLEMENTAR

  runApp(
    MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => WorkingTimeController()),
    ],
    child: const WorkingTimeApp(),
  )
  );
}
