import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart';

class CustomCheckboxField extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CustomCheckboxField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      builder: (state) {
        return Row(
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.primaryblue,
            ),
            GestureDetector(onTap: () => onChanged(!value), child: Text(label)),
          ],
        );
      },
    );
  }
}
