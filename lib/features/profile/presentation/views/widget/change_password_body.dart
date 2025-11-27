import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/auth/presentation/login/veiws/login_screen.dart';
import 'package:smartcare/features/profile/data/Model/input_model/change_password_request.dart';
import 'package:smartcare/features/profile/presentation/Cubits/profile/profilecubit.dart';
import 'package:smartcare/features/profile/presentation/Cubits/profile/profilestate.dart';
import 'package:smartcare/features/profile/presentation/views/profile_screen.dart';
import 'package:smartcare/features/profile/presentation/views/widget/Change_password_button.dart';
import 'package:smartcare/features/profile/presentation/views/widget/password_feild.dart';

class ChangePasswordBody extends StatelessWidget {
  ChangePasswordBody({super.key});

  final email = TextEditingController();

  final newPassController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [
            const SizedBox(height: 40),

            Image.network(
              "https://cdn-icons-png.flaticon.com/512/2913/2913465.png",
              height: 140,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 20),

            const Text(
              "Change Password",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            Form(
              key: formKey,
              child: Column(
                children: [
                  PasswordField(controller: email, hint: "Email", icon: null),
                  const SizedBox(height: 18),
                  PasswordField(
                    controller: newPassController,
                    hint: "New Password",
                    icon: Icons.lock_outline,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            BlocListener<Profilecubit, Profilestate>(
              listener: (context, state) {
                if (state is ChangePasswordSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.model.message ?? '')),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                } else if (state is ProfileFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errMessage)));
                }
              },
              child: ChangePasswordButton(
                text: "CONFIRM CHANGE",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final request = ChangePasswordRequest(
                      email: email.text,
                      newpassword: newPassController.text,
                    );
                    BlocProvider.of<Profilecubit>(
                      context,
                    ).ChangePassword(request);
                  }
                },
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
