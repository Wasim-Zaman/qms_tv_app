import 'package:flutter/material.dart';
import 'package:qms_tv_app/presentation/features/patients/models/patient_model.dart';
import 'package:qms_tv_app/presentation/features/patients/widgets/patient_card.dart';

/// Desktop/TV version - Center layout with main patient in center and others on sides
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
    if (patients.isEmpty) {
      return const SizedBox.shrink();
    }

    // Main patient (first in list)
    final mainPatient = patients[0];
    final mainStatusColor = getStatusColor(mainPatient.status);
    final mainStatusIcon = getStatusIcon(mainPatient.status);

    // Side patients (remaining)
    final sidePatients = patients.length > 1 ? patients.sublist(1) : [];
    final splitIndex = (sidePatients.length / 2).ceil();

    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(32)),
      child: Row(
        children: [
          // Left sidebar - top 3 patients
          Expanded(
            flex: 1,
            child: _buildSidePanel(
              List<PatientModel>.from(sidePatients.take(splitIndex)),
              isLeft: true,
            ),
          ),
          // Center - main patient
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: SingleChildScrollView(
                  child: PatientCardDesktop(
                    patient: mainPatient,
                    index: 0,
                    statusColor: mainStatusColor,
                    statusIcon: mainStatusIcon,
                  ),
                ),
              ),
            ),
          ),
          // Right sidebar - remaining patients
          Expanded(
            flex: 1,
            child: _buildSidePanel(
              List<PatientModel>.from(sidePatients.skip(splitIndex)),
              isLeft: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidePanel(
    List<PatientModel> sidePatients, {
    required bool isLeft,
  }) {
    if (sidePatients.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      itemCount: sidePatients.length,
      itemBuilder: (context, index) {
        final patient = sidePatients[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: PatientCardSide(
            patient: patient,
            index: index,
            statusColor: getStatusColor(patient.status),
            statusIcon: getStatusIcon(patient.status),
          ),
        );
      },
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
