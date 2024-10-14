import 'package:flutter/material.dart';
import 'package:real_appraiser/common_utilis/colors.dart';

class ArrowChipButton extends StatelessWidget {
  final String label; // Text label for the chip
  final bool isExpanded; // Boolean to determine the arrow direction
  final VoidCallback onToggle; // Callback for toggling the visibility

  const ArrowChipButton({
    super.key,
    required this.label,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: InkWell(
        onTap: onToggle,
        child: Chip(
          side: BorderSide(color: RAColors.colorM),
          shadowColor: RAColors.colorM,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          labelPadding: const EdgeInsets.only(left: 10, right: 10),
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: RAColors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: "AldrichRegular",
                ),
              ),
              const Spacer(),
              Icon(
                isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: RAColors.white,
                size: 24,
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: RAColors.colorM,
        ),
      ),
    );
  }
}
