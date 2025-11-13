import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:qms_tv_app/core/constants/app_colors.dart';
import 'package:qms_tv_app/core/extensions/sizedbox_extension.dart';
import 'package:qms_tv_app/core/router/app_routes.dart';
import 'package:qms_tv_app/presentation/features/auth/provider/login_provider.dart';
import 'package:qms_tv_app/presentation/features/patients/models/patient_model.dart';
import 'package:qms_tv_app/presentation/features/patients/provider/patients_provider.dart';
import 'package:qms_tv_app/presentation/widgets/custom_scaffold.dart';

/// TV Display Screen for showing called patients in a hospital queue
class TvDisplayScreen extends ConsumerStatefulWidget {
  const TvDisplayScreen({super.key});

  @override
  ConsumerState<TvDisplayScreen> createState() => _TvDisplayScreenState();
}

class _TvDisplayScreenState extends ConsumerState<TvDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    final patientsAsync = ref.watch(patientsProvider);
    final loginState = ref.watch(loginProvider);

    return CustomScaffold(
      backgroundColor: const Color(0xFF0F172A), // Dark blue background
      body: Column(
        children: [
          // Header
          _buildHeader(context, loginState.value?.user?.name ?? 'User'),

          // Content
          Expanded(
            child: patientsAsync.when(
              data: (patients) {
                if (patients.isEmpty) {
                  return _buildEmptyState();
                }
                return _buildPatientsList(patients);
              },
              loading: () => _buildLoadingState(),
              error: (error, stack) => _buildErrorState(error),
            ),
          ),

          // Footer
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String userName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.kPrimaryColor,
            AppColors.kPrimaryColor.withOpacity(0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo/Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
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
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                4.heightBox,
                Text(
                  'Called Patients Display',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          // Current Time
          _buildLiveTime(),
          24.widthBox,
          // User info and logout
          _buildUserInfo(context, userName),
        ],
      ),
    );
  }

  Widget _buildLiveTime() {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Iconsax.clock, color: Colors.white, size: 20),
              8.widthBox,
              Text(
                DateFormat('HH:mm:ss').format(DateTime.now()),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFeatures: [const FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUserInfo(BuildContext context, String userName) {
    return PopupMenuButton<String>(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Iconsax.user, color: Colors.white, size: 20),
            8.widthBox,
            Text(
              userName,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            8.widthBox,
            const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
      onSelected: (value) {
        if (value == 'logout') {
          _handleLogout();
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

  Future<void> _handleLogout() async {
    await ref.read(loginProvider.notifier).logout();
    if (mounted) {
      context.go(kLoginRoute);
    }
  }

  Widget _buildPatientsList(List<PatientModel> patients) {
    return Container(
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Table Header
          _buildTableHeader(),
          // Table Body
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: patients.length,
              itemBuilder: (context, index) {
                return _buildPatientCard(patients[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF334155),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        children: [
          _buildHeaderCell('#', flex: 1),
          _buildHeaderCell('Ticket No.', flex: 2),
          _buildHeaderCell('Patient Name', flex: 3),
          _buildHeaderCell('Department', flex: 2),
          _buildHeaderCell('Status', flex: 2),
          _buildHeaderCell('Call Time', flex: 2),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String title, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildPatientCard(PatientModel patient, int index) {
    final statusColor = _getStatusColor(patient.status);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF475569).withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withOpacity(0.3), width: 2),
      ),
      child: Row(
        children: [
          // Index
          Expanded(
            flex: 1,
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // Ticket Number
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.kPrimaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '#${patient.ticketNumber}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          8.widthBox,
          // Patient Name
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patient.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                4.heightBox,
                Text(
                  'MRN: ${patient.mrnNumber}',
                  style: const TextStyle(color: Colors.white60, fontSize: 14),
                ),
              ],
            ),
          ),
          // Department
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.withOpacity(0.5)),
              ),
              child: Text(
                patient.department.deptname,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          8.widthBox,
          // Status
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: statusColor.withOpacity(0.5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getStatusIcon(patient.status),
                    color: statusColor,
                    size: 16,
                  ),
                  4.widthBox,
                  Flexible(
                    child: Text(
                      patient.status,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          8.widthBox,
          // Call Time
          Expanded(
            flex: 2,
            child: Row(
              children: [
                const Icon(Iconsax.clock, color: Colors.white60, size: 16),
                4.widthBox,
                Text(
                  patient.firstCallTime != null
                      ? DateFormat(
                          'HH:mm',
                        ).format(DateTime.parse(patient.firstCallTime!))
                      : '--:--',
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'urgent':
        return Colors.red;
      case 'normal':
        return Colors.green;
      case 'waiting':
        return Colors.orange;
      default:
        return Colors.grey;
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

  Widget _buildEmptyState() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(48),
        margin: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Iconsax.clipboard_text,
              size: 80,
              color: Colors.white.withOpacity(0.3),
            ),
            24.heightBox,
            Text(
              'No Called Patients',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            8.heightBox,
            Text(
              'Waiting for patients to be called...',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.white60),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(48),
        margin: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.kPrimaryColor,
              ),
            ),
            24.heightBox,
            Text(
              'Loading patients...',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(Object error) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(48),
        margin: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Iconsax.warning_2,
              size: 80,
              color: AppColors.kErrorColor,
            ),
            24.heightBox,
            Text(
              'Error Loading Patients',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            8.heightBox,
            Text(
              error.toString(),
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.white60),
              textAlign: TextAlign.center,
            ),
            24.heightBox,
            ElevatedButton.icon(
              onPressed: () {
                ref.invalidate(patientsProvider);
              },
              icon: const Icon(Iconsax.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kPrimaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Iconsax.refresh, color: Colors.green, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Auto-refresh: 10s',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            DateFormat('EEEE, MMMM d, y').format(DateTime.now()),
            style: const TextStyle(color: Colors.white60, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
