import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qms_tv_app/core/network/api_client.dart';

// ==================== User Repository ====================
class UserRepo {
  final ApiClient _apiClient;

  UserRepo(this._apiClient);

  // Login method
  Future<ApiState<Map<String, dynamic>>> login({
    required String email,
    required String password,
  }) async {
    final loginData = {"email": email, "password": password};

    return _apiClient.post<Map<String, dynamic>>(
      '/user/login',
      data: loginData,
      parser: (data) => data as Map<String, dynamic>,
    );
  }
}

// ==================== User Repository Provider ====================
final userRepoProvider = Provider<UserRepo>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return UserRepo(apiClient);
});
