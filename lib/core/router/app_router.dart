import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qms_tv_app/core/constants/app_colors.dart';
import 'package:qms_tv_app/core/extensions/sizedbox_extension.dart';
import 'package:qms_tv_app/presentation/features/auth/view/login_screen.dart';
import 'package:qms_tv_app/presentation/features/patients/view/tv_display_screen_responsive.dart';
import 'package:qms_tv_app/presentation/widgets/custom_button_widget.dart';
import 'package:qms_tv_app/presentation/widgets/custom_scaffold.dart';

import 'app_routes.dart';

var navigatorKey = GlobalKey<NavigatorState>();

/// GoRouter provider for app navigation
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: kLoginRoute,
    debugLogDiagnostics: true,
    navigatorKey: navigatorKey,
    routes: [
      // Auth Routes
      GoRoute(
        path: kLoginRoute,
        name: kLoginRouteName,
        pageBuilder: (context, state) {
          return MaterialPage(key: state.pageKey, child: const LoginScreen());
        },
      ),

      GoRoute(
        path: kTvDisplayRoute,
        name: kTvDisplayRouteName,
        pageBuilder: (context, state) {
          return MaterialPage(child: TvDisplayScreen());
        },
      ),

      // Add more routes as needed
    ],
    redirect: (context, state) {
      return null; // No redirect
    },
    errorBuilder: (context, state) => CustomScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Iconsax.warning_2,
              size: 64,
              color: AppColors.kErrorColor,
            ),
            16.heightBox,
            Text(
              'Page not found: ${state.uri.path}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            16.heightBox,
            CustomButton(
              text: "Go Back",
              height: 36,
              width: 200,
              onPressed: () => context.pop(),
            ),
            12.heightBox,
            CustomOutlinedButton(
              text: "Go to Sign In",
              height: 36,
              width: 200,
              onPressed: () => context.go(kLoginRoute),
            ),
          ],
        ),
      ),
    ),
  );
});
