import 'package:equatable/equatable.dart';
import 'package:smartcare/features/profile/data/Model/AddressModel/address_model.dart';

abstract class AddressesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddressesInitial extends AddressesState {}

class AddressesLoading extends AddressesState {}

class AddressesLoaded extends AddressesState {
  final List<AddressModel> addresses;
  AddressesLoaded(this.addresses);

  @override
  List<Object?> get props => [addresses];
}

class AddressesAdded extends AddressesState {
  final AddressModel address;
  AddressesAdded(this.address);
}

class AddressRemoved extends AddressesState {
  final String addressId;
  AddressRemoved(this.addressId);
}

class AddressesError extends AddressesState {
  final String message;
  AddressesError(this.message);
}
