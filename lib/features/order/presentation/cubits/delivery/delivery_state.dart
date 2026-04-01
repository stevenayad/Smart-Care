part of 'delivery_cubit.dart';

class DeliveryState extends Equatable {
  final int selectedTab;
  final String? selectedStoreId;
  final String? selectedAddressId;

  const DeliveryState({
    this.selectedTab = 0,
    this.selectedStoreId,
    this.selectedAddressId,
  });

  DeliveryState copyWith({
    int? selectedTab,
    Object? selectedStoreId = _sentinel,
    Object? selectedAddressId = _sentinel,
  }) {
    return DeliveryState(
      selectedTab: selectedTab ?? this.selectedTab,
      selectedStoreId: selectedStoreId == _sentinel
          ? this.selectedStoreId
          : selectedStoreId as String?,
      selectedAddressId: selectedAddressId == _sentinel
          ? this.selectedAddressId
          : selectedAddressId as String?,
    );
  }

  @override
  List<Object?> get props => [selectedTab, selectedStoreId, selectedAddressId];
}

const Object _sentinel = Object();

