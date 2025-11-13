import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qms_tv_app/core/network/api_client.dart';

// ==================== Patient Repository ====================
class PatientRepo {
  final ApiClient _apiClient;

  PatientRepo(this._apiClient);

  // Get called patients method
  Future<ApiState<List<Map<String, dynamic>>>> getCalledPatients() async {
    return _apiClient.get<List<Map<String, dynamic>>>(
      '/v1/patients/called',
      parser: (data) {
        final responseData = data as Map<String, dynamic>;
        final patientsData = responseData['data'] as List;
        return patientsData.map((e) => e as Map<String, dynamic>).toList();
      },
    );
  }
}

// ==================== Patient Repository Provider ====================
final patientRepoProvider = Provider<PatientRepo>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return PatientRepo(apiClient);
});
