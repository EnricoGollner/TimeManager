import 'package:flutter/material.dart';
import 'package:working_time_manager/app/pages/main_page.dart';
import 'package:working_time_manager/app/pages/settings_page.dart';

import 'package:working_time_manager/app/shared/components/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          const DrawerHeader(
            child: Icon(Icons.more_time),
          ),
          const SizedBox(height: 25),
          DrawerTile(
            title: 'Registers',
            leading: const Icon(Icons.history),
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainPage(),)),
          ),
          DrawerTile(
            title: 'Settings',
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
