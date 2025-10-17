
import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart';

class CustomGenderSelector extends StatelessWidget {
  final int? groupValue;
  final ValueChanged<int?> onChanged;

  const CustomGenderSelector({
    super.key,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha:  0.7),
              ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildRadio(context, 'Male', 0),
            const SizedBox(width: 16),
            _buildRadio(context, 'Female', 1),
          ],
        ),
      ],
    );
  }

  Widget _buildRadio(BuildContext context, String label, int value) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkSurface
              : AppColors.secondaryLightColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.darkMediumGrey
                : AppColors.mediumGrey,
            width: 1.2,
          ),
        ),
        child: RadioListTile<int>(
          title: Text(label),
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: AppColors.primaryblue,
          contentPadding: EdgeInsets.zero,
          dense: true,
        ),
      ),
    );
  }
}