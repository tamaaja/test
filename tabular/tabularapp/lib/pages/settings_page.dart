import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final Function toggleTheme;
  final bool isDarkMode;

  SettingsPage({required this.toggleTheme, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Dark Mode'),
            Switch(
              value: isDarkMode,
              onChanged: (value) {
                toggleTheme();
              },
            ),
          ],
        ),
      ),
    );
  }
}