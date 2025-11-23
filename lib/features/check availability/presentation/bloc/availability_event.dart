part of 'availability_bloc.dart';

abstract class AvailabilityEvent extends Equatable {
  const AvailabilityEvent();

  @override
  List<Object> get props => [];
}
class CheckAvailabilityEvent extends AvailabilityEvent {
  final String poductId;

  const CheckAvailabilityEvent(this.poductId);

  @override
  List<Object> get props => [poductId];

}