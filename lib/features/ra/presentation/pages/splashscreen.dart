import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:real_appraiser/common_utilis/colors.dart';
import 'package:real_appraiser/common_utilis/strings.dart';
import 'package:real_appraiser/common_utilis/utilis.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  String currentYear = "2024";
  String appVersion = "1.0";

  @override
  void initState() {
    super.initState();
    getPackageInfo();
    currentYear = DateTime.now().year.toString();

    Future.delayed(const Duration(seconds: 3), () {
      Modular.to.popAndPushNamed('/${RoutingString.loginScreen}');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [RAColors.logB1, RAColors.logB2],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: RippleAnimation(
                      color: Color.fromRGBO(255, 211, 204, 0.1),
                      repeat: true,
                      ripplesCount: 3,
                      child: CircleAvatar(
                          radius: 70,
                          backgroundColor:
                              const Color.fromRGBO(255, 190, 181, 0.16),
                          child: SvgPicture.asset(
                            "assets/svg/ra_logo.svg",
                            width: 100,
                            height: 73,
                          )),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      "RealAppraiser",
                      style: TextStyle(
                          fontSize: 28,
                          color: RAColors.white,
                          fontFamily: "AldrichRegular"),
                    ),
                  ),
                  const Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Appraisal made easy",
                      style: TextStyle(
                          fontSize: 14,
                          color: RAColors.white,
                          fontFamily: "InterRegular"),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Version: $appVersion",
                  style: const TextStyle(
                      fontSize: 12,
                      color: RAColors.white,
                      fontFamily: "InterRegular"),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text("Date: ${RAString.versionDate}",
                    style: const TextStyle(
                        fontSize: 12,
                        color: RAColors.white,
                        fontFamily: "InterRegular"))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("\u00A9 $currentYear ${RAString.copyrightText}",
                  style: const TextStyle(
                      fontSize: 12,
                      color: RAColors.white,
                      fontFamily: "InterRegular")),
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
      RAUtilis.setStorage(StorageString.appVersion, appVersion);
    });
  }
}
