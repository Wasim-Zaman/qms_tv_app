import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qms_tv_app/core/constants/app_colors.dart';
import 'package:qms_tv_app/core/extensions/sizedbox_extension.dart';

/// Logo and header section with animated icon and title
class LogoHeader extends StatelessWidget {
  const LogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.kPrimaryColor.withValues(alpha: 0.3),
            AppColors.kSecondaryColor.withValues(alpha: 0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          // Animated Icon Container
          _buildIconContainer(context),
          24.heightBox,
          // Title
          Text(
            'QMS TV Display',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark
                  ? AppColors.kDarkTextPrimaryColor
                  : AppColors.kTextPrimaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          8.heightBox,
          // Subtitle
          Text(
            'Queue Management System',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: isDark
                  ? AppColors.kDarkTextSecondaryColor
                  : AppColors.kTextSecondaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildIconContainer(context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.kPrimaryColor.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Icon(
        Iconsax.monitor,
        size: 64,
        color: isDark
            ? AppColors.kDarkBackgroundColor
            : AppColors.kBackgroundColor,
      ),
    );
  }
}
