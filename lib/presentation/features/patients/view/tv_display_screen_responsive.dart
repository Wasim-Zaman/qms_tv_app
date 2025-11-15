import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qms_tv_app/core/constants/app_colors.dart';
import 'package:qms_tv_app/core/router/app_routes.dart';
import 'package:qms_tv_app/presentation/features/auth/provider/login_provider.dart';
import 'package:qms_tv_app/presentation/features/patients/models/patient_model.dart';
import 'package:qms_tv_app/presentation/features/patients/provider/patients_provider.dart';
import 'package:qms_tv_app/presentation/features/patients/widgets/display_footer.dart';
import 'package:qms_tv_app/presentation/features/patients/widgets/display_header.dart';
import 'package:qms_tv_app/presentation/features/patients/widgets/display_states.dart';
import 'package:qms_tv_app/presentation/features/patients/widgets/patients_list.dart';
import 'package:qms_tv_app/presentation/widgets/custom_scaffold.dart';

/// Responsive TV Display Screen for showing called patients in a hospital queue
/// Supports both mobile and desktop (Android TV) layouts
class TvDisplayScreen extends ConsumerStatefulWidget {
  const TvDisplayScreen({super.key});

  @override
  ConsumerState<TvDisplayScreen> createState() => _TvDisplayScreenState();
}

class _TvDisplayScreenState extends ConsumerState<TvDisplayScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  // Breakpoint for responsive design
  static const double mobileBreakpoint = 600;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < mobileBreakpoint;
        return _buildResponsiveLayout(isMobile);
      },
    );
  }

  Widget _buildResponsiveLayout(bool isMobile) {
    final patientsAsync = ref.watch(patientsProvider);
    final loginState = ref.watch(loginProvider);

    return CustomScaffold(
      body: Column(
        children: [
          // Header
          DisplayHeader(
            userName: loginState.value?.user?.name ?? 'User',
            onLogout: _handleLogout,
            isMobile: isMobile,
          ),

          // Content
          Expanded(
            child: patientsAsync.when(
              data: (patients) {
                if (patients.isEmpty) {
                  return EmptyStateWidget(isMobile: isMobile);
                }
                return _buildPatientsList(patients, isMobile);
              },
              loading: () => LoadingStateWidget(isMobile: isMobile),
              error: (error, stack) =>
                  ErrorStateWidget(error: error, isMobile: isMobile),
            ),
          ),

          // Footer
          DisplayFooter(isMobile: isMobile),
        ],
      ),
    );
  }

  Widget _buildPatientsList(List<PatientModel> patients, bool isMobile) {
    if (isMobile) {
      return PatientsListMobile(
        patients: patients,
        getStatusColor: _getStatusColor,
        getStatusIcon: _getStatusIcon,
      );
    } else {
      return PatientsListDesktop(
        patients: patients,
        getStatusColor: _getStatusColor,
        getStatusIcon: _getStatusIcon,
      );
    }
  }

  Future<void> _handleLogout() async {
    await ref.read(loginProvider.notifier).logout();
    if (mounted) {
      context.go(kLoginRoute);
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'urgent':
        return AppColors.kErrorColor;
      case 'normal':
        return AppColors.kSuccessColor;
      case 'waiting':
        return AppColors.kWarningColor;
      default:
        return AppColors.kGreyColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'urgent':
        return Iconsax.warning_2;
      case 'normal':
        return Iconsax.tick_circle;
      case 'waiting':
        return Iconsax.clock;
      default:
        return Iconsax.info_circle;
    }
  }
}
