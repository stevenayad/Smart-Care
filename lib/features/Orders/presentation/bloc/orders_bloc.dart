import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:smartcare/features/Orders/domain/repositories/order_repository.dart';
import 'orders_event.dart';
import 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrderRepository repository;

  OrdersBloc({required this.repository}) : super(OrdersInitial()) {
    on<FetchOrderById>(_onFetchOrderById);
    on<FetchOrderDetails>(_onFetchOrderDetails);
    on<FetchOrdersByCustomer>(_onFetchOrdersByCustomer);
    on<FetchOrdersByCustomerAndStatus>(_onFetchOrdersByCustomerAndStatus);
  }

  Future<void> _onFetchOrderById(
    FetchOrderById event,
    Emitter<OrdersState> emit,
  ) async {
    emit(OrdersLoading());
    try {
      final result = await repository.getOrderById(event.id);
      result.fold(
        (failure) => emit(OrdersError(failure.errMessage)),
        (order) => emit(OrderLoaded(order)),
      );
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  Future<void> _onFetchOrderDetails(
    FetchOrderDetails event,
    Emitter<OrdersState> emit,
  ) async {
    emit(OrdersLoading());
    try {
      final result = await repository.getOrderDetails(event.id);
      result.fold(
        (failure) => emit(OrdersError(failure.errMessage)),
        (order) => emit(OrderLoaded(order)),
      );
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  Future<void> _onFetchOrdersByCustomer(
    FetchOrdersByCustomer event,
    Emitter<OrdersState> emit,
  ) async {
    emit(OrdersLoading());
    try {
      final result = await repository.getOrdersByCustomer();
      result.fold(
        (failure) => emit(OrdersError(failure.errMessage)),
        (orders) => emit(OrdersListLoaded(orders)),
      );
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  Future<void> _onFetchOrdersByCustomerAndStatus(
    FetchOrdersByCustomerAndStatus event,
    Emitter<OrdersState> emit,
  ) async {
    emit(OrdersLoading());
    try {
      final result = await repository.getOrdersByCustomerAndStatus(
        event.clientId,
        event.status,
      );
      result.fold(
        (failure) => emit(OrdersError(failure.errMessage)),
        (orders) => emit(OrdersListLoaded(orders)),
      );
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }
}
