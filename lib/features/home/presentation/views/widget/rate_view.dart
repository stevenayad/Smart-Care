import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smartcare/features/home/data/Model/details_product_model/details_product_model.dart';

import 'package:smartcare/features/home/data/Model/rateinputrequest.dart';
import 'package:smartcare/features/home/presentation/cubits/rate/rate_cubit.dart';

class Ratereview extends StatefulWidget {
  final DetailsProductModel detialsProductModel;

  const Ratereview({super.key, required this.detialsProductModel});

  @override
  State<Ratereview> createState() => _RatereviewState();
}

class _RatereviewState extends State<Ratereview> {
  double currentRating = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RateCubit, RateState>(
      listener: (context, state) {
        if (state is RateLoaded) {
          setState(() {
            currentRating = state.rating.toDouble();
          });
        } else if (state is RateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Your rating has been saved successfully!'),
            ),
          );
        } else if (state is RateFaliure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: ${state.errmessage}')));
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rate this product:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            RatingBar.builder(
              initialRating: currentRating,
              minRating: 1,
              allowHalfRating: false,
              itemCount: 5,
              itemSize: 30,
              glow: false,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) =>
                  const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {
                setState(() {
                  currentRating = rating;
                });
              },
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: currentRating == 0
                  ? null
                  : () {
                      final request = RateInputRequest(
                        productId:
                            widget.detialsProductModel.data?.productId ?? '',
                        value: currentRating.round(),
                        createdAt: DateTime.now()
                            .toUtc()
                            .subtract(const Duration(minutes: 1))
                            .toIso8601String(),
                      );
                      context.read<RateCubit>().createrate(request);
                    },
              child: const Text('Submit Rating'),
            ),
          ],
        );
      },
    );
  }
}
