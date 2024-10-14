import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_appraiser/common_utilis/colors.dart';

class CommonLoader extends StatelessWidget {
  const CommonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: RAColors.colorM,
      ),
    );
  }
}
