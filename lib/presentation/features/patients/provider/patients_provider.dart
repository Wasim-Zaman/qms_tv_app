import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qms_tv_app/core/network/api_client.dart';
import 'package:qms_tv_app/presentation/features/patients/models/patient_model.dart';
import 'package:qms_tv_app/repos/patient_repo.dart';

/// Provider for fetching called patients with auto-refresh
class PatientsNotifier extends AsyncNotifier<List<PatientModel>> {
  Timer? _refreshTimer;

  @override
  Future<List<PatientModel>> build() async {
    // Start auto-refresh every 10 seconds
    _startAutoRefresh();

    // Load initial data
    return await _fetchPatients();
  }

  void _startAutoRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      refresh();
    });
  }

  Future<List<PatientModel>> _fetchPatients() async {
    final patientRepo = ref.read(patientRepoProvider);
    final result = await patientRepo.getCalledPatients();

    switch (result) {
      case ApiSuccess(:final data):
        return data.map((json) => PatientModel.fromJson(json)).toList();
      case ApiError(:final message):
        throw Exception(message);
      default:
        throw Exception('Failed to fetch patients');
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchPatients());
  }

  void stopAutoRefresh() {
    _refreshTimer?.cancel();
  }
}

/// Provider for called patients list
final patientsProvider =
    AsyncNotifierProvider<PatientsNotifier, List<PatientModel>>(() {
      return PatientsNotifier();
    });
