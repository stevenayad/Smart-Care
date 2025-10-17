import 'package:flutter/material.dart';

class EditProfileImagePicker extends StatelessWidget {
  const EditProfileImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: colorScheme.primary.withOpacity(0.2),
              child: const Text(
                'JD',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                backgroundColor: colorScheme.primary,
                radius: 18,
                child: Icon(
                  Icons.camera_alt,
                  color: colorScheme.surface,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'Tap to change photo',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
        ),
      ],
    );
  }
}
