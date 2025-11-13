import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qms_tv_app/core/constants/app_colors.dart';
import 'package:qms_tv_app/presentation/widgets/custom_text_field.dart';

/// Email input field widget
class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;
  final String? Function(String?)? validator;

  const EmailField({
    super.key,
    required this.controller,
    required this.isLoading,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      labelText: 'Email Address',
      hintText: 'Enter your email',
      prefixIcon: const Icon(
        Iconsax.sms,
        color: AppColors.kIconSecondaryColor,
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: validator,
      enabled: !isLoading,
    );
  }
}
