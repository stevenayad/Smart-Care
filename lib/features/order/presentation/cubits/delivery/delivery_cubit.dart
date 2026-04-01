import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'delivery_state.dart';

class DeliveryCubit extends Cubit<DeliveryState> {
  DeliveryCubit() : super(const DeliveryState());

  void selectTab(int tab) {
    if (state.selectedTab == tab) return;
    emit(state.copyWith(selectedTab: tab));
  }

  void selectStore(String id) {
    if (state.selectedStoreId == id) return;
    emit(state.copyWith(selectedStoreId: id));
  }

  void selectAddress(String id) {
    if (state.selectedAddressId == id) return;
    emit(state.copyWith(selectedAddressId: id));
  }
}

