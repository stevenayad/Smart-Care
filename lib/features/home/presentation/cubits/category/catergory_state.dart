part of 'catergory_cubit.dart';

abstract class GatergoryState {}

final class GatergoryInitial extends GatergoryState {}

class GatergroySucess extends GatergoryState {
  final CategoryPagintedModel catergoryModel;

  GatergroySucess({required this.catergoryModel});
  @override
  List<Object> get props => [catergoryModel];
}

class GatergroyFaliure extends GatergoryState {
  final String errMessage;

  GatergroyFaliure({required this.errMessage});
}

class GatergroyLoading extends GatergoryState {}
