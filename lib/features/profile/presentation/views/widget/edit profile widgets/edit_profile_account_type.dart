import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/profile/presentation/Cubits/editprofile/editprofilecubit.dart';
import 'package:smartcare/features/profile/presentation/Cubits/editprofile/editprofilestate.dart';

class EditProfileAccountType extends StatelessWidget {
  const EditProfileAccountType({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Editprofilecubit, EditProfilestate>(
      buildWhen: (previous, current) =>
          current is EditProfileAccountTypeChanged,
      builder: (context, state) {
        final cubit = context.read<Editprofilecubit>();
        final options = [
          {'label': 'Self Use', 'value': 0, 'icon': Icons.person},
          {'label': 'Family Use', 'value': 1, 'icon': Icons.family_restroom},
        ];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Account Type",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: options.map((option) {
                final selected = cubit.accountType == option['value'];
                return GestureDetector(
                  onTap: () => cubit.setAccountType(option['value'] as int),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: selected ? Colors.green.shade50 : Colors.white,
                      border: Border.all(
                        color: selected ? Colors.green : Colors.grey.shade300,
                        width: selected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: selected
                          ? [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.2),
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
                          color: selected ? Colors.green : Colors.grey,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          option['label'] as String,
                          style: TextStyle(
                            color: selected
                                ? Colors.green
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
