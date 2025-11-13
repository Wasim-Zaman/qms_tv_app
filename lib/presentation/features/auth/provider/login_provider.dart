import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qms_tv_app/core/network/api_client.dart';
import 'package:qms_tv_app/presentation/features/auth/models/user_model.dart';
import 'package:qms_tv_app/repos/user_repo.dart';
import 'package:qms_tv_app/services/shared_preferences_service.dart';

// Login state class
class LoginState {
  final bool isLoading;
  final UserModel? user;
  final String? error;
  final bool isAuthenticated;

  const LoginState({
    this.isLoading = false,
    this.user,
    this.error,
    this.isAuthenticated = false,
  });

  LoginState copyWith({
    bool? isLoading,
    UserModel? user,
    String? error,
    bool? isAuthenticated,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}

/// AsyncNotifier for login business logic
class LoginNotifier extends AsyncNotifier<LoginState> {
  @override
  Future<LoginState> build() async {
    // Check if user is already logged in
    final prefsService = ref.read(sharedPreferencesServiceProvider);
    final isLoggedIn = prefsService.isLoggedIn();

    if (isLoggedIn) {
      final userData = prefsService.getMemberData();

      if (userData != null) {
        try {
          final user = UserModel.fromJson(userData);
          return LoginState(isAuthenticated: true, user: user);
        } catch (e) {
          // If parsing fails, clear stored data
          await prefsService.removeToken();
          await prefsService.removeMemberData();
          await prefsService.setLoggedIn(false);
        }
      }
    }

    // Initialize with default state
    return const LoginState();
  }

  /// Login with email and password
  Future<void> login(String email, String password) async {
    // Set loading state
    state = const AsyncValue.loading();

    try {
      // Get user repository and prefs service
      final userRepo = ref.read(userRepoProvider);
      final prefsService = ref.read(sharedPreferencesServiceProvider);

      // Call login API
      final result = await userRepo.login(email: email, password: password);

      // Handle API response
      if (result is ApiSuccess<Map<String, dynamic>>) {
        // Parse user data from response
        final userData = result.data['data']['user'] as Map<String, dynamic>;
        final user = UserModel.fromJson(userData);

        // Save user data and token to shared preferences
        await prefsService.saveToken(user.accessToken);
        await prefsService.saveMemberData(userData);
        await prefsService.setLoggedIn(true);

        // Login successful
        state = AsyncValue.data(
          LoginState(isLoading: false, isAuthenticated: true, user: user),
        );
      } else if (result is ApiError<Map<String, dynamic>>) {
        // Login failed
        state = AsyncValue.data(
          LoginState(
            isLoading: false,
            isAuthenticated: false,
            error: result.message,
          ),
        );
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Logout user
  Future<void> logout() async {
    final prefsService = ref.read(sharedPreferencesServiceProvider);

    await prefsService.removeToken();
    await prefsService.removeMemberData();
    await prefsService.setLoggedIn(false);

    state = const AsyncValue.data(LoginState());
  }
}

// Provider for login notifier
final loginProvider = AsyncNotifierProvider<LoginNotifier, LoginState>(() {
  return LoginNotifier();
});
