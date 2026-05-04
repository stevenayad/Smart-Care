part of 'checkout_cubit.dart';

class CheckoutState extends Equatable {
  final int selectedTab;
  final String? selectedStoreId;
  final String? selectedAddressId;
  final int? selectedAddressIndex;

  const CheckoutState({
    this.selectedTab = 0,
    this.selectedStoreId,
    this.selectedAddressId,
    this.selectedAddressIndex,
  });

  CheckoutState copyWith({
    int? selectedTab,
    Object? selectedStoreId = _sentinel,
    Object? selectedAddressId = _sentinel,
    Object? selectedAddressIndex = _sentinel,
  }) {
    return CheckoutState(
      selectedTab: selectedTab ?? this.selectedTab,
      selectedStoreId: selectedStoreId == _sentinel
          ? this.selectedStoreId
          : selectedStoreId as String?,
      selectedAddressId: selectedAddressId == _sentinel
          ? this.selectedAddressId
          : selectedAddressId as String?,
      selectedAddressIndex: selectedAddressIndex == _sentinel
          ? this.selectedAddressIndex
          : selectedAddressIndex as int?,
    );
  }

  @override
  List<Object?> get props => [
        selectedTab,
        selectedStoreId,
        selectedAddressId,
        selectedAddressIndex,
      ];
}

const Object _sentinel = Object();
