import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:smartcare/core/api/services/cache_helper.dart';
import 'package:smartcare/core/token_storage.dart';
part 'authcubit_state.dart';

class AuthCubit extends Cubit<AuthcubitState> {
  final TokenStorage storage = TokenStorage();

  AuthCubit() : super(AuthcubitInitial());

  bool _isLoggingOut = false;

  Future<void> checkAuth() async {
    final token = await storage.getAccessToken();
    final isExpired = await storage.isAccessTokenExpired();

    if (token != null && !isExpired) {
      emit(Authenticated());
    } else if (token != null) {
      // نخلي Dio يتصرف
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> logout() async {
    if (_isLoggingOut) return;

    _isLoggingOut = true;

    debugPrint("🚪 Logging out...");

    await storage.clear();
    await CacheHelper.clearAll();

    emit(Unauthenticated());

    _isLoggingOut = false;
  }

  void forceLogout() {
    logout();
  }
}
