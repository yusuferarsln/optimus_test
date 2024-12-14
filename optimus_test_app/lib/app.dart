import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:optimus_test_app/constants/app_colors.dart';
import 'package:optimus_test_app/views/Home.dart';
import 'package:optimus_test_app/views/SplashScreen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        colorScheme: const ColorScheme.light(
            primary: AppColors.lblue,
            onPrimary: Colors.black,
            surface: Colors.white,
            onSurface: Colors.black,
            outline: Colors.black,
            onSurfaceVariant: Colors.white),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
            primary: AppColors.dblue,
            onPrimary: Colors.white,
            surface: AppColors.dBblue,
            onSurface: Colors.white,
            outline: AppColors.dblue,
            onSurfaceVariant: AppColors.dblue),
      ),
      themeMode: ThemeMode.system,
      title: 'Optimus',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
