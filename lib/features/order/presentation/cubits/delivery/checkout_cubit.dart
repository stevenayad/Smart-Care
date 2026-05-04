import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare/features/order/data/model/address_model/datum.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(const CheckoutState());

  void selectTab(int tab) {
    if (state.selectedTab == tab) return;
    emit(state.copyWith(selectedTab: tab));
  }

  void selectStore(String id) {
    if (state.selectedStoreId == id) return;
    emit(state.copyWith(selectedStoreId: id));
  }

  void initAddresses(List<AddressDatum> addresses) {
    if (addresses.isEmpty) return;


    if (state.selectedAddressId == null) {
      final defaultIndex = addresses.indexWhere((e) => e.isPrimary == true);

      if (defaultIndex != -1) {
        final defaultAddress = addresses[defaultIndex];
        emit(state.copyWith(
          selectedAddressId: defaultAddress.id ?? "",
          selectedAddressIndex: defaultIndex,
        ));
      }
    }
  }

  void selectAddress(String id, int index) {
    if (state.selectedAddressId == id && state.selectedAddressIndex == index) {
      return;
    }
    emit(state.copyWith(
      selectedAddressId: id,
      selectedAddressIndex: index,
    ));
  }
}
