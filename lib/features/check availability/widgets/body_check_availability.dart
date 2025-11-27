import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/check%20availability/presentation/bloc/availability_bloc.dart';
import 'package:smartcare/features/check%20availability/widgets/store_card.dart';

class BodyCheckAvailablity extends StatelessWidget {
  const BodyCheckAvailablity({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvailabilityBloc, AvailabilityState>(
      builder: (context, state) {
        if (state is AvailabilityLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AvailabilityFailure) {
          return Center(child: Text(state.message));
        } else if (state is AvailabilitySuccess) {
          final invetories = state.inventories;
          if (invetories.isEmpty) {
            return const Center(child: Text('No Availability found'));
          }
          return ListView.builder(
            itemCount: invetories.length,
            itemBuilder: (context, index) {
              final inventory = invetories[index];
              return Column(
                children: [
                  if (index == 0)
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 0.5,
                        ),
                      ),
                      child: Text(
                        inventory.productName,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  StoreCard(inventory: inventory),
                ],
              );
            },
          );
        }
        return const Center(
          child: Text('Search for a product to see availability'),
        );
      },
    );
  }
}
