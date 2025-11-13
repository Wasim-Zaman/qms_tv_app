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
    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      decoration: BoxDecoration(
        color: AppColors.kDarkSurfaceColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.kDarkShadowColor,
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(isMobile ? 6 : 8),
                decoration: BoxDecoration(
                  color: AppColors.kSuccessColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.refresh,
                      color: AppColors.kSuccessColor,
                      size: isMobile ? 14 : 16,
                    ),
                    SizedBox(width: isMobile ? 3 : 4),
                    Text(
                      'Auto-refresh: 10s',
                      style: TextStyle(
                        color: AppColors.kSuccessColor,
                        fontSize: isMobile ? 10 : 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            isMobile
                ? DateFormat('MMM d, yyyy').format(DateTime.now())
                : DateFormat('EEEE, MMMM d, y').format(DateTime.now()),
            style: TextStyle(
              color: AppColors.kDarkTextTertiaryColor,
              fontSize: isMobile ? 11 : 14,
            ),
          ),
        ],
      ),
    );
  }
}
