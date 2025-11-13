import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qms_tv_app/core/constants/app_colors.dart';
import 'package:qms_tv_app/core/extensions/sizedbox_extension.dart';
import 'package:qms_tv_app/core/router/app_routes.dart';
import 'package:qms_tv_app/core/utils/custom_snackbar.dart';
import 'package:qms_tv_app/presentation/features/auth/provider/login_provider.dart';
import 'package:qms_tv_app/presentation/features/auth/provider/validation_provider.dart';
import 'package:qms_tv_app/presentation/widgets/custom_button_widget.dart';
import 'package:qms_tv_app/presentation/widgets/custom_scaffold.dart';
import 'package:qms_tv_app/presentation/widgets/custom_text_field.dart';

/// Modern login screen for QMS TV App
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      await ref
          .read(loginProvider.notifier)
          .login(_emailController.text.trim(), _passwordController.text);

      final loginState = ref.read(loginProvider);
      loginState.whenData((state) {
        if (state.isAuthenticated && mounted) {
          context.go(kTvDisplayRoute);
        } else if (state.error != null && mounted) {
          CustomSnackbar.showError(context, state.error!);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);
    final isLoading = loginState.isLoading;
    final size = MediaQuery.of(context).size;

    final validator = ref.read(validationProvider.notifier);

    return CustomScaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Logo and Title Section
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.kPrimaryColor.withValues(alpha: 0.1),
                              AppColors.kSecondaryColor.withValues(alpha: 0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            // TV/Monitor Icon
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: AppColors.kPrimaryColor,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.kPrimaryColor.withValues(
                                      alpha: 0.3,
                                    ),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Iconsax.monitor,
                                size: 64,
                                color: Colors.white,
                              ),
                            ),
                            24.heightBox,
                            Text(
                              'QMS TV Display',
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.kTextPrimaryColor,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            8.heightBox,
                            Text(
                              'Queue Management System',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: AppColors.kTextSecondaryColor,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                      48.heightBox,

                      // Login Form Card
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Welcome Back',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.kTextPrimaryColor,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            8.heightBox,
                            Text(
                              'Sign in to access the TV display',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: AppColors.kTextSecondaryColor,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            32.heightBox,

                            // Email Field
                            CustomTextField(
                              controller: _emailController,
                              labelText: 'Email Address',
                              hintText: 'Enter your email',
                              prefixIcon: const Icon(
                                Iconsax.sms,
                                color: AppColors.kIconSecondaryColor,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validator: validator.validateEmail,
                              enabled: !isLoading,
                            ),

                            20.heightBox,

                            // Password Field
                            CustomTextField(
                              controller: _passwordController,
                              labelText: 'Password',
                              hintText: 'Enter your password',
                              prefixIcon: const Icon(
                                Iconsax.lock,
                                color: AppColors.kIconSecondaryColor,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Iconsax.eye_slash
                                      : Iconsax.eye,
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
                              validator: validator.validatePassword,
                              enabled: !isLoading,
                              onFieldSubmitted: (_) => _handleLogin(),
                            ),

                            32.heightBox,

                            // Login Button
                            CustomButton(
                              text: 'Sign In',
                              onPressed: isLoading ? null : _handleLogin,
                              isLoading: isLoading,
                              icon: const Icon(
                                Iconsax.login,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),

                      24.heightBox,

                      // Footer
                      Text(
                        'Hospital Queue Management System',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.kTextTertiaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
