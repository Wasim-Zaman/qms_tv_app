import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qms_tv_app/core/constants/app_colors.dart';
import 'package:qms_tv_app/presentation/widgets/custom_text_field.dart';

/// Password input field widget with show/hide toggle
class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final bool isLoading;
  final String? Function(String?)? validator;
  final VoidCallback onSubmitted;

  const PasswordField({
    super.key,
    required this.controller,
    required this.isLoading,
    this.validator,
    required this.onSubmitted,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: widget.controller,
      labelText: 'Password',
      hintText: 'Enter your password',
      prefixIcon: const Icon(
        Iconsax.lock,
        color: AppColors.kIconSecondaryColor,
      ),
      suffixIcon: IconButton(
        icon: Icon(
          _obscurePassword ? Iconsax.eye_slash : Iconsax.eye,
          color: AppColors.kIconSecondaryColor,
        ),
        onPressed: () {
          setState(() {
            _obscurePassword = !_obscurePassword;
          });
        },
      ),
      obscureText: _obscurePassword,
      textInputAction: TextInputAction.done,
      validator: widget.validator,
      enabled: !widget.isLoading,
      onFieldSubmitted: (_) => widget.onSubmitted(),
    );
  }
}
