import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/api/services/cache_helper.dart';
import 'package:smartcare/features/auth/presentation/login/veiws/login_screen.dart';
import 'package:smartcare/features/profile/presentation/Cubits/profile/profilecubit.dart';
import 'package:smartcare/features/profile/presentation/Cubits/profile/profilestate.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<Profilecubit, Profilestate>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        }
      },
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              showLogoutDialog(context);
            },
            style: Theme.of(context).elevatedButtonTheme.style,
            child: Text(
              'Log out',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    final parentContext = context;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return LogoutDialog(parentContext: parentContext);
      },
    );
  }
}

class LogoutDialog extends StatelessWidget {
  final BuildContext parentContext;

  const LogoutDialog({super.key, required this.parentContext});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titlePadding: const EdgeInsets.only(top: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

      title: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.logout, size: 40, color: Colors.red.shade400),
          ),
          const SizedBox(height: 12),
          Text(
            "Logout",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade900,
            ),
          ),
        ],
      ),

      content: Text(
        "Are you sure you want to log out of your account?",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          height: 1.4,
          color: Colors.grey.shade700,
        ),
      ),

      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actionsPadding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),

      actions: [
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.grey.shade200,
          ),
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Cancel",
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
            backgroundColor: Colors.red.shade400,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
          ),
          onPressed: () async {
            final cubit = BlocProvider.of<Profilecubit>(parentContext);
            cubit.Logout();
            await CacheHelper.removeAccessToken();
          },
          child: const Text(
            "Logout",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
