import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare/features/order/data/model/address_model/address_model.dart';
import 'package:smartcare/features/order/data/model/address_model/datum.dart';
import 'package:smartcare/features/order/data/model/store_model/datum.dart';
import 'package:smartcare/features/order/data/repo/orderrepo.dart';

part 'address_store_state.dart';

class AddressStoreCubit extends Cubit<AddressStoreState> {
  final Orderrepo orderrepo;

  AddressStoreCubit(this.orderrepo) : super(const AddressStoreState());

  Future<void> getstore() async {
    emit(state.copyWith(isStoreLoading: true, storeError: null));
    final result = await orderrepo.getstore();
    result.fold(
      (failure) => emit(
        state.copyWith(isStoreLoading: false, storeError: failure.errMessage),
      ),
      (model) =>
          emit(state.copyWith(isStoreLoading: false, stores: model.data ?? [])),
    );
  }

  Future<void> getaddress() async {
    emit(state.copyWith(isAddressLoading: true, addressError: null));
    final result = await orderrepo.getaddress();
    result.fold(
      (failure) => emit(
        state.copyWith(
          isAddressLoading: false,
          addressError: failure.errMessage,
        ),
      ),
      (model) => emit(
        state.copyWith(isAddressLoading: false, addresses: model.data ?? []),
      ),
    );
  }
}
