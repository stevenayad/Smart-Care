import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smartcare/features/home/data/Model/details_product_model/details_product_model.dart';
import 'package:smartcare/features/home/data/Model/rateinputrequest.dart';
import 'package:smartcare/features/home/presentation/cubits/rate/rate_cubit.dart';

class RateReview extends StatefulWidget {
  final DetailsProductModel detailsProductModel;

  const RateReview({super.key, required this.detailsProductModel});

  @override
  State<RateReview> createState() => _RateReviewState();
}

class _RateReviewState extends State<RateReview> {
  double currentRating = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RateCubit, RateState>(
      listener: (context, state) {
        if (state is RateLoaded) {
          currentRating = state.rating.toDouble();
        } else if (state is RateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Rating submitted successfully!')),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Row(
            children: [
              Center(
                child: RatingBar.builder(
                  initialRating: currentRating,
                  minRating: 1,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                  itemSize: 20,
                  glow: false,
                  itemBuilder: (_, __) =>
                      const Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) {
                    setState(() => currentRating = rating);

                    final request = RateInputRequest(
                      productId:
                          widget.detailsProductModel.data?.productId ?? '',
                      value: rating.round(),
                      createdAt: DateTime.now()
                          .toUtc()
                          .subtract(const Duration(minutes: 1))
                          .toIso8601String(),
                    );

                    context.read<RateCubit>().createrate(request);
                  },
                ),
              ),
              const SizedBox(width: 3),
              Container(
                child: Text(
                  currentRating.toStringAsFixed(1),
                  style: const TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "(${widget.detailsProductModel.data?.totalRatings.toString() ?? ""})",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
