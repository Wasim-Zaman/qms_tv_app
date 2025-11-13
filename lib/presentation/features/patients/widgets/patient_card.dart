import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:qms_tv_app/core/constants/app_colors.dart';
import 'package:qms_tv_app/core/extensions/sizedbox_extension.dart';
import 'package:qms_tv_app/presentation/features/patients/models/patient_model.dart';

/// Desktop/TV version of patient card - horizontal table row layout
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
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.kBlueGreyColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withValues(alpha: 0.3), width: 2),
      ),
      child: Row(
        children: [
          // Index
          Expanded(
            flex: 1,
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                color: AppColors.kDarkTextSecondaryColor,
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
                  color: AppColors.kTextOnPrimaryColor,
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
                    color: AppColors.kTextOnPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                4.heightBox,
                Text(
                  'MRN: ${patient.mrnNumber}',
                  style: const TextStyle(
                    color: AppColors.kDarkTextTertiaryColor,
                    fontSize: 14,
                  ),
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
                color: AppColors.kInfoColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.kInfoColor.withValues(alpha: 0.5),
                ),
              ),
              child: Text(
                patient.department.deptname,
                style: const TextStyle(
                  color: AppColors.kInfoColor,
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
                color: statusColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: statusColor.withValues(alpha: 0.5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(statusIcon, color: statusColor, size: 16),
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
                const Icon(
                  Iconsax.clock,
                  color: AppColors.kDarkTextTertiaryColor,
                  size: 16,
                ),
                4.widthBox,
                Text(
                  patient.firstCallTime != null
                      ? DateFormat(
                          'HH:mm',
                        ).format(DateTime.parse(patient.firstCallTime!))
                      : '--:--',
                  style: const TextStyle(
                    color: AppColors.kDarkTextSecondaryColor,
                    fontSize: 14,
                  ),
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
