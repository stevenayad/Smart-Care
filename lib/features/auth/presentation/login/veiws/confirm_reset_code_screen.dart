import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/app_theme.dart';
import 'package:smartcare/features/auth/presentation/Bloc/auth_bloc/auth_bloc.dart';
import 'package:smartcare/features/auth/presentation/login/veiws/reset_new_password_screen.dart';

class ConfirmResetCodeScreen extends StatefulWidget {
  final String email;
  const ConfirmResetCodeScreen({super.key, required this.email});

  @override
  State<ConfirmResetCodeScreen> createState() => _ConfirmResetCodeScreenState();
}

class _ConfirmResetCodeScreenState extends State<ConfirmResetCodeScreen> {
  final TextEditingController _codeController = TextEditingController();

  void _submit() {
    final code = _codeController.text.trim();
    if (code.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter the code")));
      return;
    }

    context.read<AuthBloc>().add(ConfirmResetCodeEvent(widget.email, code));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemes.customAppBar(
        title: 'Confirm Code',
        showBackButton: true,
        isDarkMode: false,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ResetCodeConfirmedSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ResetNewPasswordScreen(email: widget.email),
              ),
            );
          }
        },
        builder: (context, state) {
          final loading = state is AuthLoading;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: _codeController,
                  decoration: const InputDecoration(label: Text("Code")),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: loading ? null : _submit,
                  child: loading
                      ? const CircularProgressIndicator()
                      : const Text("Confirm Code"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
