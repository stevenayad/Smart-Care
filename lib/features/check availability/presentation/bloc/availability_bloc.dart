import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/check%20availability/data/model/inventory_model.dart';
import 'package:smartcare/features/check%20availability/domain/repositories/availability_repo.dart';

part 'availability_event.dart';
part 'availability_state.dart';

class AvailabilityBloc extends Bloc<AvailabilityEvent, AvailabilityState> {
  final AvailabilityRepo repo;
  AvailabilityBloc(this.repo) : super(AvailabilityInitial()) {
    on<CheckAvailabilityEvent>((event, emit) async {
      emit(AvailabilityLoading());
      final result=await repo.checkAvailability(event.poductId);
      result.fold(
        (failure)=>emit(AvailabilityFailure(failure.errMessage)),
        (data)=>emit(AvailabilitySuccess(data))
      );

    });
  }
}
