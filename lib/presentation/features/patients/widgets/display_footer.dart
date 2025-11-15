import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qms_tv_app/core/constants/app_colors.dart';

/// Footer widget for the TV Display Screen
/// Shows auto-refresh status and current date
class DisplayFooter extends StatelessWidget {
  final bool isMobile;

  const DisplayFooter({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.kDarkSurfaceColor : AppColors.kSurfaceColor,
        boxShadow: [
          BoxShadow(
            color: isDark ? AppColors.kDarkShadowColor : AppColors.kShadowColor,
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          isMobile
              ? DateFormat('MMM d, yyyy').format(DateTime.now())
              : DateFormat('EEEE, MMMM d, y').format(DateTime.now()),
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.kDarkTextTertiaryColor
                : AppColors.kTextSecondaryColor,
            fontSize: isMobile ? 11 : 14,
          ),
        ),
      ),
    );
  }
}
