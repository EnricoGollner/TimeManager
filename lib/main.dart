import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:working_time_manager/app/controller/register_controller.dart';
import 'package:working_time_manager/app/data/models/duration_adapter.dart';
import 'package:working_time_manager/app/data/models/register.dart';
import 'package:working_time_manager/app/main_app.dart';
import 'package:working_time_manager/core/theme/theme_provider.dart';

Future<void> main() async {
  await Hive.initFlutter();

  ///Registering adapters in Hive
  Hive.registerAdapter(DurationAdapter());
  Hive.registerAdapter(RegisterAdapter());

  ///Opening hives box (creating table)
  await Hive.openBox<Register>('registers');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => WorkingTimeController()),
      ],
      child: const WorkingTimeApp(),
    ),
  );
}
