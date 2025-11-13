import 'package:flutter/material.dart';
import 'package:qms_tv_app/core/constants/app_colors.dart';

/// Footer text widget
class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Hospital Queue Management System',
      style: Theme.of(
        context,
      ).textTheme.bodySmall?.copyWith(color: AppColors.kDarkTextSecondaryColor),
      textAlign: TextAlign.center,
    );
  }
}
