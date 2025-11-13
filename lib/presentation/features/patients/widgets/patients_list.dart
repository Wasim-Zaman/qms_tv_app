import 'package:flutter/material.dart';
import 'package:qms_tv_app/presentation/features/patients/models/patient_model.dart';
import 'package:qms_tv_app/presentation/features/patients/widgets/patient_card.dart';

/// Desktop/TV version - Large card layout (one patient per row)
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
      margin: const EdgeInsets.all(16),
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
