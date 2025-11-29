import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/profile/data/repo/addresses_repository.dart';
import 'addresses_event.dart';
import 'addresses_state.dart';

class AddressesBloc extends Bloc<AddressesEvent, AddressesState> {
  final AddressesRepository repo;

  AddressesBloc(this.repo) : super(AddressesInitial()) {

    on<GetAddressesEvent>((event, emit) async {
      emit(AddressesLoading());

      final result = await repo.getAddresses();

      result.fold(
        (l) => emit(AddressesError(l.errMessage)),
        (r) => emit(AddressesLoaded(r)),
      );
    });


    on<AddAddressEvent>((event, emit) async {
      emit(AddressesLoading());

      final result = await repo.addAddress(event.address);

      result.fold(
        (l) => emit(AddressesError(l.errMessage)),
        (r) => emit(AddressesAdded(r)),
      );
    });


    on<RemoveAddressEvent>((event, emit) async {
      emit(AddressesLoading());

      final result = await repo.removeAddress(event.addressId);

      result.fold(
        (l) => emit(AddressesError(l.errMessage)),
        (r) => emit(AddressRemoved(event.addressId)),
      );
    });
  }
}
