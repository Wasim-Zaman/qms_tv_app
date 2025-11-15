import 'package:flutter/material.dart';
import 'package:qms_tv_app/core/constants/app_colors.dart';

/// Login form container with card styling
class LoginFormCard extends StatelessWidget {
  final Widget child;

  const LoginFormCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? AppColors.kDarkShadowColor : AppColors.kShadowColor,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
