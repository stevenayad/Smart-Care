part of 'availability_bloc.dart';

abstract class AvailabilityState extends Equatable {
  const AvailabilityState();

  @override
  List<Object> get props => [];
}

class AvailabilityInitial extends AvailabilityState {}

class AvailabilityLoading extends AvailabilityState {}

class AvailabilitySuccess extends AvailabilityState {
  final List<InventoryModel> inventories;
  const AvailabilitySuccess(this.inventories);
  @override
  List<Object> get props => [inventories];
}

class AvailabilityFailure extends AvailabilityState {
  final String message;
  const AvailabilityFailure(this.message);
  @override
  List<Object> get props => [message];
}
