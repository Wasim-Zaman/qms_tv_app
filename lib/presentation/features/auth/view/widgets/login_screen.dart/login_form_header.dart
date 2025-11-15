import 'package:flutter/material.dart';
import 'package:qms_tv_app/core/constants/app_colors.dart';
import 'package:qms_tv_app/core/extensions/sizedbox_extension.dart';

/// Login form header with welcome message
class LoginFormHeader extends StatelessWidget {
  const LoginFormHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Welcome Back',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        8.heightBox,
        Text(
          'Sign in to access the TV display',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isDark
                ? AppColors.kDarkTextSecondaryColor
                : AppColors.kTextSecondaryColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
