import 'package:flutter/material.dart';
import 'package:smartcare/features/profile/presentation/views/widget/custom_text_feild.dart';

class CityZip extends StatelessWidget {
  const CityZip({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: CustomTextFormField(
            label: 'City',
            icon: Icons.location_city_outlined,
            controller: null,
            keyboardType: TextInputType.text,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: CustomTextFormField(
            label: 'ZIP Code',
            icon: Icons.markunread_mailbox_outlined,
            controller: null,
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}
