import 'package:flutter/material.dart';
import 'package:real_appraiser/common_utilis/colors.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(backgroundColor: RAColors.colorPrimaryDark,),
    );
  }
}
