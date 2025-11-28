import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/profile/presentation/Cubits/editprofile/editprofilecubit.dart';
import 'package:smartcare/features/profile/presentation/Cubits/editprofile/editprofilestate.dart';

class EditProfileGenderSelection extends StatelessWidget {
  const EditProfileGenderSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Editprofilecubit, EditProfilestate>(
      buildWhen: (previous, current) => current is EditProfileGenderChanged,
      builder: (context, state) {
        final cubit = context.read<Editprofilecubit>();
        final options = [
          {
            'label': 'Not Prefer to Say',
            'value': 0,
            'icon': Icons.help_outline,
          },
          {'label': 'Male', 'value': 1, 'icon': Icons.male},
          {'label': 'Female', 'value': 2, 'icon': Icons.female},
        ];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Gender",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: options.map((option) {
                final selected = cubit.gender == option['value'];
                return GestureDetector(
                  onTap: () => cubit.setGender(option['value'] as int),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: selected ? Colors.blue.shade50 : Colors.white,
                      border: Border.all(
                        color: selected ? Colors.blue : Colors.grey.shade300,
                        width: selected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: selected
                          ? [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.2),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ]
                          : [],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          option['icon'] as IconData,
                          color: selected ? Colors.blue : Colors.grey,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          option['label'] as String,
                          style: TextStyle(
                            color: selected
                                ? Colors.blue
                                : Colors.grey.shade800,
                            fontWeight: selected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
