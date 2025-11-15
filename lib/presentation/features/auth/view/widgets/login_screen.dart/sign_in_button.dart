import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qms_tv_app/core/constants/app_colors.dart';
import 'package:qms_tv_app/presentation/widgets/custom_button_widget.dart';

/// Sign in button widget
class SignInButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;

  const SignInButton({super.key, required this.isLoading, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return CustomButton(
      text: 'Sign In',
      onPressed: isLoading ? null : onPressed,
      isLoading: isLoading,
      icon: Icon(
        Iconsax.login,
        color: isDark
            ? AppColors.kDarkBackgroundColor
            : AppColors.kBackgroundColor,
      ),
    );
  }
}
