part of 'detailsproduct_cubit.dart';

sealed class DetailsproductState extends Equatable {
  const DetailsproductState();

  @override
  List<Object> get props => [];
}

final class DetailsproductInitial extends DetailsproductState {}

class DetailsproductSuccess extends DetailsproductState {
  final DetailsProductModel detialsProductModel;

  DetailsproductSuccess({required this.detialsProductModel});
}

class DetailsproductFaliure extends DetailsproductState {
  final String errMesssage;

  DetailsproductFaliure({required this.errMesssage});
}

class DetailsproductLoading extends DetailsproductState {}
