import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare/core/token_storage.dart';

part 'authcubit_state.dart';

class AuthCubit extends Cubit<AuthcubitState> {
  final TokenStorage storage;

  AuthCubit(this.storage) : super(AuthcubitInitial());

  Future<void> checkAuth() async {
    final isLogged = await storage.getAccessToken() != null;

    if (isLogged) {
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> logout() async {
    await storage.clear();
    emit(Unauthenticated());
  }
}
