import 'package:bloc/bloc.dart';
import 'package:smartcare/features/Orders/data/models/order_model.dart';
import 'package:smartcare/features/Orders/data/repositories/order_repository.dart';
import 'orders_event.dart';
import 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrderRepository repository;
  List<OrderModel> _cachedOrders = [];
  bool _hasFetchedList = false;

  OrdersBloc({required this.repository}) : super(OrdersInitial()) {
    on<FetchOrderById>(_onFetchOrderById);
    on<FetchOrderDetails>(_onFetchOrderDetails);
    on<FetchOrdersByCustomer>(_onFetchOrdersByCustomer);
    on<FetchOrdersByCustomerAndStatus>(_onFetchOrdersByCustomerAndStatus);
    on<RestoreOrdersList>(_onRestoreOrdersList);
  }

  void _onRestoreOrdersList(
    RestoreOrdersList event,
    Emitter<OrdersState> emit,
  ) {
    if (_hasFetchedList) {
      emit(OrdersListLoaded(_cachedOrders));
    } else {
      add(FetchOrdersByCustomer());
    }
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
      result.fold((failure) => emit(OrdersError(failure.errMessage)), (orders) {
        _cachedOrders = orders;
        _hasFetchedList = true;
        emit(OrdersListLoaded(orders));
      });
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
      result.fold((failure) => emit(OrdersError(failure.errMessage)), (orders) {
        _cachedOrders = orders;
        _hasFetchedList = true;
        emit(OrdersListLoaded(orders));
      });
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }
}
