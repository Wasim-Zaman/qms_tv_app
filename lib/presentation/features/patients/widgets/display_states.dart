import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qms_tv_app/core/constants/app_colors.dart';
import 'package:qms_tv_app/core/extensions/sizedbox_extension.dart';
import 'package:qms_tv_app/presentation/features/patients/provider/patients_provider.dart';

/// Empty state widget when no patients are available
class EmptyStateWidget extends StatelessWidget {
  final bool isMobile;

  const EmptyStateWidget({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(isMobile ? 32 : 48),
        margin: EdgeInsets.all(isMobile ? 16 : 24),
        decoration: BoxDecoration(
          color: AppColors.kDarkSurfaceColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Iconsax.clipboard_text,
              size: isMobile ? 60 : 80,
              color: AppColors.kTextOnPrimaryColor.withValues(alpha: 0.3),
            ),
            (isMobile ? 16 : 24).heightBox,
            Text(
              'No Called Patients',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.kTextOnPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: isMobile ? 18 : null,
              ),
            ),
            8.heightBox,
            Text(
              'Waiting for patients to be called...',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.kDarkTextTertiaryColor,
                fontSize: isMobile ? 14 : null,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Loading state widget
class LoadingStateWidget extends StatelessWidget {
  final bool isMobile;

  const LoadingStateWidget({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(isMobile ? 32 : 48),
        margin: EdgeInsets.all(isMobile ? 16 : 24),
        decoration: BoxDecoration(
          color: AppColors.kDarkSurfaceColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: isMobile ? 40 : 50,
              height: isMobile ? 40 : 50,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.kPrimaryColor,
                ),
              ),
            ),
            (isMobile ? 16 : 24).heightBox,
            Text(
              'Loading patients...',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.kDarkTextSecondaryColor,
                fontSize: isMobile ? 14 : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Error state widget with retry button
class ErrorStateWidget extends ConsumerWidget {
  final Object error;
  final bool isMobile;

  const ErrorStateWidget({
    super.key,
    required this.error,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(isMobile ? 32 : 48),
        margin: EdgeInsets.all(isMobile ? 16 : 24),
        decoration: BoxDecoration(
          color: AppColors.kDarkSurfaceColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Iconsax.warning_2,
              size: isMobile ? 60 : 80,
              color: AppColors.kErrorColor,
            ),
            (isMobile ? 16 : 24).heightBox,
            Text(
              'Error Loading Patients',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.kTextOnPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: isMobile ? 18 : null,
              ),
            ),
            8.heightBox,
            Text(
              error.toString(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.kDarkTextTertiaryColor,
                fontSize: isMobile ? 13 : null,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            (isMobile ? 16 : 24).heightBox,
            ElevatedButton.icon(
              onPressed: () {
                ref.invalidate(patientsProvider);
              },
              icon: const Icon(Iconsax.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kPrimaryColor,
                foregroundColor: AppColors.kTextOnPrimaryColor,
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 32,
                  vertical: isMobile ? 12 : 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
