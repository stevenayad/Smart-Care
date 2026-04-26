import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/auth/presentation/Manager/request_bloc/request_bloc.dart';
import 'package:smartcare/features/auth/presentation/login/veiws/widgets/login_validator.dart';

part 'logic_login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthBloc authBloc;
  late final StreamSubscription authBlocSubscription;

  LoginCubit({required this.authBloc}) : super(const LoginState()) {
    authBlocSubscription = authBloc.stream.listen((authState) {
      if (isClosed) return; //without this line give error in Profile Cubit
      if (authState is AuthLoading) {
        emit(state.copyWith(isLoading: true, clearErrorMessage: true));
      } else if (authState is AuthFailure) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: authState.errorMessage,
          ),
        );
      } else if (authState is LoginSuccess) {
        emit(state.copyWith(isLoading: false, clearErrorMessage: true));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    });
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }

  void onEmailChanged(String email) {
    emit(state.copyWith(email: email, clearErrorMessage: true));
  }

  void onPasswordChanged(String password) {
    emit(state.copyWith(password: password, clearErrorMessage: true));
  }

  void clearErrorMessage() {
    emit(state.copyWith(clearErrorMessage: true));
  }

  void onLoginPressed() {
    final email = state.email.trim();
    final password = state.password;

    final errorMessage = LoginValidator.validateFields(
      email: email,
      password: password,
    );

    if (errorMessage != null) {
      emit(state.copyWith(errorMessage: errorMessage));
      return;
    }

    emit(state.copyWith(clearErrorMessage: true));
    authBloc.add(LoginButtonPressed(email: email, password: password));
  }
}
