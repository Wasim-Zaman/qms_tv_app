import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qms_tv_app/core/constants/app_colors.dart';
import 'package:qms_tv_app/core/extensions/sizedbox_extension.dart';
import 'package:qms_tv_app/core/router/app_routes.dart';
import 'package:qms_tv_app/core/utils/custom_snackbar.dart';
import 'package:qms_tv_app/presentation/features/auth/provider/login_provider.dart';
import 'package:qms_tv_app/presentation/features/auth/provider/validation_provider.dart';
import 'package:qms_tv_app/presentation/features/auth/view/widgets/login_screen.dart/widgets.dart';
import 'package:qms_tv_app/presentation/widgets/custom_scaffold.dart';

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
                      const LogoHeader(),

                      48.heightBox,

                      // Login Form Card
                      LoginFormCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Form Header
                            const LoginFormHeader(),

                            32.heightBox,

                            // Email Field
                            EmailField(
                              controller: _emailController,
                              isLoading: isLoading,
                              validator: validator.validateEmail,
                            ),

                            20.heightBox,

                            // Password Field
                            PasswordField(
                              controller: _passwordController,
                              isLoading: isLoading,
                              validator: validator.validatePassword,
                              onSubmitted: _handleLogin,
                            ),

                            32.heightBox,

                            // Sign In Button
                            SignInButton(
                              isLoading: isLoading,
                              onPressed: _handleLogin,
                            ),
                          ],
                        ),
                      ),

                      24.heightBox,

                      // Footer
                      const LoginFooter(),
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
