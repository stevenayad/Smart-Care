part of 'best_seller_cubit.dart';

sealed class BestSellerState extends Equatable {
  const BestSellerState();

  @override
  List<Object> get props => [];
}

final class BestSellerInitial extends BestSellerState {}

class BestSellerSuccess extends BestSellerState {
  final BestSellerModel bestSellerModel;

  BestSellerSuccess({required this.bestSellerModel});
}

class BestSellerFailure extends BestSellerState {
  final String errMessage;

  BestSellerFailure({required this.errMessage});
}

class BestSellerLoading extends BestSellerState {}
