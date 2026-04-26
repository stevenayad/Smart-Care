import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare/core/api/services/cache_helper.dart';
import 'package:smartcare/core/token_storage.dart';

part 'authcubit_state.dart';

class AuthCubit extends Cubit<AuthcubitState> {
  final TokenStorage storage = TokenStorage(); // Use Singleton

  AuthCubit() : super(AuthcubitInitial());

  /// Guard to prevent multiple logout triggers.
  bool _isLoggingOut = false;

  Future<void> checkAuth() async {
    final token = await storage.getAccessToken();
    final isExpired = await storage.isAccessTokenExpired();

    if (token != null && !isExpired) {
      emit(Authenticated());
    } else {
      // If token exists but is expired, checkAuth might trigger a refresh 
      // if called from a place that uses Dio. Here we just check state.
      if (token != null) {
        emit(Authenticated()); // Still authenticated, Dio will handle refresh
      } else {
        emit(Unauthenticated());
      }
    }
  }

  /// Performs a safe logout, ensuring it only happens once.
  Future<void> logout() async {
    if (_isLoggingOut) return;
    _isLoggingOut = true;

    print("🚪 Logging out...");
    await storage.clear();
    await CacheHelper.clearAll();
    
    emit(Unauthenticated());
    
    // Reset guard after state change to allow future logins
    _isLoggingOut = false;
  }

  /// Force logout triggered by Interceptor or other services.
  void forceLogout() {
    logout();
  }
}
