part of 'address_store_cubit.dart';

class AddressStoreState extends Equatable {
  final bool isStoreLoading;
  final bool isAddressLoading;
  final List<StoreDatum> stores;
  final List<AddressDatum> addresses;
  final String? storeError;
  final String? addressError;

  const AddressStoreState({
    this.isStoreLoading = false,
    this.isAddressLoading = false,
    this.stores = const [],
    this.addresses = const [],
    this.storeError,
    this.addressError,
  });

  AddressStoreState copyWith({
    bool? isStoreLoading,
    bool? isAddressLoading,
    List<StoreDatum>? stores,
    List<AddressDatum>? addresses,
    String? storeError,
    String? addressError,
  }) {
    return AddressStoreState(
      isStoreLoading: isStoreLoading ?? this.isStoreLoading,
      isAddressLoading: isAddressLoading ?? this.isAddressLoading,
      stores: stores ?? this.stores,
      addresses: addresses ?? this.addresses,
      storeError: storeError,
      addressError: addressError,
    );
  }

  @override
  List<Object?> get props => [
    isStoreLoading,
    isAddressLoading,
    stores,
    addresses,
    storeError,
    addressError,
  ];
}
