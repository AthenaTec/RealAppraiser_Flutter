import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:real_appraiser/common_utilis/colors.dart';
import 'package:real_appraiser/common_utilis/strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  String currentYear = "2024";
  String appVersion = "1.0";

  @override
  void initState() {
    super.initState();
    getPackageInfo();
    currentYear = DateTime.now().year.toString();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    animationController.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Modular.to.popAndPushNamed('/${RoutingString.loginScreen}');
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/png/background.png"),
                  fit: BoxFit.cover),
        //     gradient: LinearGradient(colors: [
        //   RAColors.colorPrimaryDark,
        //   Color.fromRGBO(225, 255, 255, 0.1),
        //   RAColors.colorPrimaryDark
        // ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  child: FadeTransition(
                    opacity: animation,
                    child: Image.asset(
                      "assets/png/ra_logo.png",
                      width: 300,
                      height: 200,
                    ),
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  appVersion,
                  style: const TextStyle(fontSize: 14, color: RAColors.white),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(RAString.versionDate,
                    style: const TextStyle(fontSize: 14, color: RAColors.white))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("\u00A9 $currentYear ${RAString.copyrightText}",
                  style: const TextStyle(fontSize: 14, color: RAColors.white)),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version.toString();
    });
  }
}
