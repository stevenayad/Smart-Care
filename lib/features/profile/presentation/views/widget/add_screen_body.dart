import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/profile/presentation/views/widget/address_type.dart';
import 'package:smartcare/features/profile/presentation/views/widget/address_type_item.dart';
import 'package:smartcare/features/profile/presentation/views/widget/city_zip.dart';
import 'package:smartcare/features/profile/presentation/views/widget/custom_evaluted_button.dart';
import 'package:smartcare/features/profile/presentation/views/widget/custom_text_feild.dart';

class AddScreenBody extends StatelessWidget {
  const AddScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'Address Type',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 4),
            const AdrressType(),
            const SizedBox(height: 20),
            CustomTextFormField(
              label: 'Address Label',
              icon: Icons.label_outline,
              controller: null,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              label: 'Full Name',
              icon: Icons.person_outline,
              controller: null,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              label: 'Street Address',
              icon: Icons.streetview,
              controller: null,
              keyboardType: TextInputType.streetAddress,
            ),
            const SizedBox(height: 20),
            const CityZip(),
            const SizedBox(height: 20),
            CustomTextFormField(
              label: 'Phone Number',
              icon: Icons.phone_outlined,
              controller: null,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 30),
            CustomElevatedButton(
              text: 'Save Address',
              onPressed: () {},
              backgroundColor: AppColors.primaryLightColor,
              textColor: Theme.of(
                context,
              ).colorScheme.onSurface.withOpacity(0.7),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              isFullWidth: true,
            ),
            const SizedBox(height: 30),
            CustomElevatedButton(
              text: 'Cancel',
              onPressed: () {},
              backgroundColor: Colors.transparent,
              textColor: Theme.of(
                context,
              ).colorScheme.onSurface.withOpacity(0.7),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              isFullWidth: true,
            ),
          ],
        ),
      ),
    );
  }
}
