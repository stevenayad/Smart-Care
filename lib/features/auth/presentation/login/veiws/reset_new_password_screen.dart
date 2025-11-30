import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/app_theme.dart';
import 'package:smartcare/features/auth/presentation/Bloc/auth_bloc/auth_bloc.dart';

class ResetNewPasswordScreen extends StatefulWidget {
  final String email;
  const ResetNewPasswordScreen({super.key, required this.email});

  @override
  State<ResetNewPasswordScreen> createState() => _ResetNewPasswordScreenState();
}

class _ResetNewPasswordScreenState extends State<ResetNewPasswordScreen> {
  final TextEditingController _passController = TextEditingController();

  void _submit() {
    final pass = _passController.text.trim();
    if (pass.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter your new password")));
      return;
    }

    context.read<AuthBloc>().add(ResetPasswordEvent(widget.email, pass));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemes.customAppBar(
        title: 'Reset Password',
        showBackButton: true,
        isDarkMode: false,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is PasswordResetSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.response.message ?? "Password Reset"),
              ),
            );
            Navigator.popUntil(context, (c) => c.isFirst);
          }
        },
        builder: (context, state) {
          final loading = state is AuthLoading;
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: _passController,
                  decoration: const InputDecoration(
                    label: Text("New Password"),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: loading ? null : _submit,
                  child: loading
                      ? const CircularProgressIndicator()
                      : const Text("Reset Password"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
