import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:qms_tv_app/core/constants/app_colors.dart';
import 'package:qms_tv_app/core/extensions/sizedbox_extension.dart';

/// Header widget for the TV Display Screen
/// Displays logo, title, time, and user info
class DisplayHeader extends StatelessWidget {
  final String userName;
  final VoidCallback onLogout;
  final bool isMobile;

  const DisplayHeader({
    super.key,
    required this.userName,
    required this.onLogout,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 12 : 20,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.kPrimaryColor,
            AppColors.kPrimaryColor.withValues(alpha: 0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? AppColors.kDarkShadowColor : AppColors.kShadowColor,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: isMobile
          ? _buildMobileHeader(context)
          : _buildDesktopHeader(context),
    );
  }

  Widget _buildDesktopHeader(BuildContext context) {
    return Row(
      children: [
        // Logo/Icon
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.kSurfaceColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Iconsax.hospital,
            size: 32,
            color: AppColors.kPrimaryColor,
          ),
        ),
        16.widthBox,
        // Title
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hospital Queue Management',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.kTextOnPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              4.heightBox,
              Text(
                'Called Patients Display',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.kTextOnPrimaryColor.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ),
        // Current Time
        const LiveTimeWidget(),
        24.widthBox,
        // User info and logout
        UserInfoWidget(userName: userName, onLogout: onLogout),
      ],
    );
  }

  Widget _buildMobileHeader(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // Logo/Icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.kSurfaceColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Iconsax.hospital,
                size: 24,
                color: AppColors.kPrimaryColor,
              ),
            ),
            12.widthBox,
            // Title
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Queue Management',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.kTextOnPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  2.heightBox,
                  Text(
                    'Patient Display',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.kTextOnPrimaryColor.withValues(
                        alpha: 0.9,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // User info
            UserInfoWidget(
              userName: userName,
              onLogout: onLogout,
              compact: true,
            ),
          ],
        ),
        12.heightBox,
        // Time and status bar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const LiveTimeWidget(compact: true),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.kSuccessColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Iconsax.refresh,
                    color: AppColors.kSuccessColor,
                    size: 12,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Live',
                    style: TextStyle(
                      color: AppColors.kSuccessColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Widget to display live time
class LiveTimeWidget extends StatelessWidget {
  final bool compact;

  const LiveTimeWidget({super.key, this.compact = false});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 8 : 16,
            vertical: compact ? 4 : 8,
          ),
          decoration: BoxDecoration(
            color: AppColors.kTextOnPrimaryColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(compact ? 4 : 8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Iconsax.clock,
                color: AppColors.kTextOnPrimaryColor,
                size: compact ? 14 : 20,
              ),
              SizedBox(width: compact ? 4 : 8),
              Text(
                DateFormat('HH:mm:ss').format(DateTime.now()),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.kTextOnPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: compact ? 12 : null,
                  fontFeatures: [const FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Widget to display user info with logout option
class UserInfoWidget extends StatelessWidget {
  final String userName;
  final VoidCallback onLogout;
  final bool compact;

  const UserInfoWidget({
    super.key,
    required this.userName,
    required this.onLogout,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 8 : 16,
          vertical: compact ? 4 : 8,
        ),
        decoration: BoxDecoration(
          color: AppColors.kTextOnPrimaryColor.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(compact ? 4 : 8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Iconsax.user,
              color: AppColors.kTextOnPrimaryColor,
              size: compact ? 16 : 20,
            ),
            if (!compact) ...[
              8.widthBox,
              Text(
                userName,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.kTextOnPrimaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              8.widthBox,
              const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.kTextOnPrimaryColor,
                size: 20,
              ),
            ],
          ],
        ),
      ),
      onSelected: (value) {
        if (value == 'logout') {
          onLogout();
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'logout',
          child: Row(
            children: [
              Icon(Iconsax.logout, size: 20),
              SizedBox(width: 12),
              Text('Logout'),
            ],
          ),
        ),
      ],
    );
  }
}
