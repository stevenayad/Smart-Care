import 'package:flutter/material.dart';

class UserData extends StatelessWidget {
  const UserData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('John Doe', style: Theme.of(context).textTheme.bodyLarge),

        Text(
          'john.doe@example.com',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [Color(0xFFE3EDF7), Color(0xFFD7E4EF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Premium Member",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(width: 6),
              const Icon(
                Icons.auto_awesome,
                size: 16,
                color: Color(0xFF3E4A59),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
