import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_appraiser/common_utilis/colors.dart';
import 'package:intl/intl.dart';

class HighlightedTag extends StatelessWidget {
  final DateTime dateTime; // Add this to accept DateTime
  final String status; // Add this to accept status text

  const HighlightedTag({
    super.key,
    required this.dateTime,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    // Formatting the DateTime object
    String month = DateFormat('MMM').format(dateTime);
    String day = DateFormat('d').format(dateTime);
    String year = DateFormat('yyyy').format(dateTime);
    String time = DateFormat('HH:mm').format(dateTime);

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        // Use Card instead of Container
        Card(
          color: RAColors.dateTag,
          elevation: 3, // Adds shadow to the card
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Text(
                    month,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: RAColors.white,
                      fontFamily: "InterRegular",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    day,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: RAColors.white,
                      fontFamily: "AldrichRegular",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    year,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: RAColors.white,
                      fontFamily: "AldrichRegular",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    time,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: RAColors.white,
                      fontFamily: "AldrichRegular",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Positioned ribbon tag at the top
        Positioned(
          top: 10,
          left: -1,
          right: -1,
          child: SvgPicture.asset(
            "assets/svg/tag.svg",
            width: 90,
            height: 32,
          ),
        ),
        // Positioned text over the ribbon
        Positioned(
          top: 12,
          left: 10,
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(
              status,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
