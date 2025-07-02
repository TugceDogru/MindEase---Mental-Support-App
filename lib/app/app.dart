import 'package:flutter/material.dart';
import 'routes.dart';
import '../theme/app_theme.dart';

class MindEaseApp extends StatelessWidget {
  const MindEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MindEase',
      theme: AppTheme.lightTheme,
      initialRoute: Routes.login,
      routes: Routes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
