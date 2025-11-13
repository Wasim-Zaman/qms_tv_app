import 'package:flutter/material.dart';
import 'package:qms_tv_app/core/constants/app_colors.dart';
import 'package:qms_tv_app/presentation/features/patients/models/patient_model.dart';
import 'package:qms_tv_app/presentation/features/patients/widgets/patient_card.dart';

/// Desktop/TV version - Table layout with header
class PatientsListDesktop extends StatelessWidget {
  final List<PatientModel> patients;
  final Color Function(String) getStatusColor;
  final IconData Function(String) getStatusIcon;

  const PatientsListDesktop({
    super.key,
    required this.patients,
    required this.getStatusColor,
    required this.getStatusIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.kDarkSurfaceColor,
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
                final patient = patients[index];
                return PatientCardDesktop(
                  patient: patient,
                  index: index,
                  statusColor: getStatusColor(patient.status),
                  statusIcon: getStatusIcon(patient.status),
                );
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
        color: AppColors.kDarkBorderLightColor,
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
          color: AppColors.kTextOnPrimaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

/// Mobile version - Scrollable card list
class PatientsListMobile extends StatelessWidget {
  final List<PatientModel> patients;
  final Color Function(String) getStatusColor;
  final IconData Function(String) getStatusIcon;

  const PatientsListMobile({
    super.key,
    required this.patients,
    required this.getStatusColor,
    required this.getStatusIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: patients.length,
      itemBuilder: (context, index) {
        final patient = patients[index];
        return PatientCardMobile(
          patient: patient,
          index: index,
          statusColor: getStatusColor(patient.status),
          statusIcon: getStatusIcon(patient.status),
        );
      },
    );
  }
}
