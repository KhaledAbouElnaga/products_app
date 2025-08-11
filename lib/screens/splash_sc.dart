import 'package:beggining/widgets/circular_progress_indicator.dart';
import 'package:beggining/factory/color_factory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashSc extends StatefulWidget {
  const SplashSc({super.key});

  @override
  State<SplashSc> createState() => _SplashScState();
}

class _SplashScState extends State<SplashSc> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    // Simulate a delay for splash screen
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Get.offAllNamed('/signup');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorFactory.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Auth App",
              style: TextStyle(
                  fontSize: 24,
                  color: ColorFactory.textWhite,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicatorClass(
              circularProgressIndicator: CircularProgressIndicator(),
            ).cPI()
          ],
        ),
      ),
    );
  }
}
