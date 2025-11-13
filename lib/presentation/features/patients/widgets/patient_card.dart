import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:qms_tv_app/core/constants/app_colors.dart';
import 'package:qms_tv_app/core/extensions/sizedbox_extension.dart';
import 'package:qms_tv_app/presentation/features/patients/models/patient_model.dart';

/// Desktop/TV version of patient card - Large prominent display layout
class PatientCardDesktop extends StatelessWidget {
  final PatientModel patient;
  final int index;
  final Color statusColor;
  final IconData statusIcon;

  const PatientCardDesktop({
    super.key,
    required this.patient,
    required this.index,
    required this.statusColor,
    required this.statusIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.kDarkSurfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: statusColor.withValues(alpha: 0.5), width: 3),
        boxShadow: [
          BoxShadow(
            color: statusColor.withValues(alpha: 0.2),
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          // Left: Ticket Number - Large and Prominent
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ticket #',
                  style: TextStyle(
                    color: AppColors.kDarkTextTertiaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                8.heightBox,
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.kPrimaryColor.withValues(alpha: 0.3),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Text(
                    patient.ticketNumber.toString(),
                    style: const TextStyle(
                      color: AppColors.kTextOnPrimaryColor,
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          24.widthBox,
          // Middle: Patient Details
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Patient Name
                Text(
                  patient.name,
                  style: const TextStyle(
                    color: AppColors.kTextOnPrimaryColor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                12.heightBox,
                // MRN
                Row(
                  children: [
                    const Icon(
                      Iconsax.user,
                      color: AppColors.kInfoColor,
                      size: 24,
                    ),
                    12.widthBox,
                    Text(
                      'MRN: ${patient.mrnNumber}',
                      style: const TextStyle(
                        color: AppColors.kDarkTextSecondaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                12.heightBox,
                // Department
                Row(
                  children: [
                    const Icon(
                      Iconsax.hospital,
                      color: AppColors.kInfoColor,
                      size: 24,
                    ),
                    12.widthBox,
                    Text(
                      patient.department.deptname,
                      style: const TextStyle(
                        color: AppColors.kInfoColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
          24.widthBox,
          // Right: Status and Time
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: statusColor.withValues(alpha: 0.6),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(statusIcon, color: statusColor, size: 40),
                      8.heightBox,
                      Text(
                        patient.status,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                24.heightBox,
                // Call Time
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Iconsax.clock,
                      color: AppColors.kDarkTextTertiaryColor,
                      size: 24,
                    ),
                    8.widthBox,
                    Text(
                      patient.firstCallTime != null
                          ? DateFormat(
                              'HH:mm',
                            ).format(DateTime.parse(patient.firstCallTime!))
                          : '--:--',
                      style: const TextStyle(
                        color: AppColors.kDarkTextSecondaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Mobile version of patient card - vertical card layout
class PatientCardMobile extends StatelessWidget {
  final PatientModel patient;
  final int index;
  final Color statusColor;
  final IconData statusIcon;

  const PatientCardMobile({
    super.key,
    required this.patient,
    required this.index,
    required this.statusColor,
    required this.statusIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.kDarkSurfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withValues(alpha: 0.5), width: 2),
        boxShadow: [
          BoxShadow(
            color: statusColor.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row - Ticket and Status
          Row(
            children: [
              // Ticket Number
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Iconsax.ticket,
                      color: AppColors.kTextOnPrimaryColor,
                      size: 16,
                    ),
                    6.widthBox,
                    Text(
                      '#${patient.ticketNumber}',
                      style: const TextStyle(
                        color: AppColors.kTextOnPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor.withValues(alpha: 0.5)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, color: statusColor, size: 14),
                    4.widthBox,
                    Text(
                      patient.status,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          16.heightBox,
          // Patient Name
          Text(
            patient.name,
            style: const TextStyle(
              color: AppColors.kTextOnPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          8.heightBox,
          // Patient Details
          _buildInfoRow(
            icon: Iconsax.user_octagon,
            label: 'MRN',
            value: patient.mrnNumber,
          ),
          8.heightBox,
          _buildInfoRow(
            icon: Iconsax.hospital,
            label: 'Department',
            value: patient.department.deptname,
            valueColor: AppColors.kInfoColor,
          ),
          8.heightBox,
          _buildInfoRow(
            icon: Iconsax.clock,
            label: 'Called At',
            value: patient.firstCallTime != null
                ? DateFormat(
                    'HH:mm',
                  ).format(DateTime.parse(patient.firstCallTime!))
                : 'Not called yet',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.kDarkTextTertiaryColor, size: 16),
        8.widthBox,
        Text(
          '$label: ',
          style: const TextStyle(
            color: AppColors.kDarkTextSecondaryColor,
            fontSize: 14,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? AppColors.kTextOnPrimaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
