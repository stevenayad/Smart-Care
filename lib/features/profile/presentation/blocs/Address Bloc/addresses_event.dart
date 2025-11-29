import 'package:equatable/equatable.dart';
import 'package:smartcare/features/profile/data/Model/AddressModel/address_model.dart';

abstract class AddressesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAddressesEvent extends AddressesEvent {}

class AddAddressEvent extends AddressesEvent {
  final AddressModel address;
  AddAddressEvent(this.address);
}

class RemoveAddressEvent extends AddressesEvent {
  final String addressId;
  RemoveAddressEvent(this.addressId);
}
