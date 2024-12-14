import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optimus_test_app/constants/app_colors.dart';
import 'package:optimus_test_app/extensions/content_extension.dart';
import 'package:optimus_test_app/views/Home.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this)
          ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () => context.replace(const HomeView()));
    return CupertinoPageScaffold(
      child: Container(
        decoration: BoxDecoration(color: AppColors.dblue),
        child: Center(
          child: FadeTransition(
            opacity: _controller,
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Center(
                  child: Image.asset("assets/images/logo.png"),
                )),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
