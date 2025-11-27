import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/faluire.dart';
import '../../domain/entities/order.dart';
import '../../domain/usecases/get_order_by_id.dart';
import '../../domain/usecases/get_order_details.dart';
import '../../domain/usecases/get_orders_by_customer.dart';
import '../../domain/usecases/get_orders_by_customer_and_status.dart';
import 'orders_event.dart';
import 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetOrderById getOrderById;
  final GetOrderDetails getOrderDetails;
  final GetOrdersByCustomer getOrdersByCustomer;
  final GetOrdersByCustomerAndStatus getOrdersByCustomerAndStatus;

  OrdersBloc({
    required this.getOrderById,
    required this.getOrderDetails,
    required this.getOrdersByCustomer,
    required this.getOrdersByCustomerAndStatus,
  }) : super(OrdersInitial()) {
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
    final Either<Failure, Orderr> result = await getOrderById(event.id);
    result.fold(
      (failure) => emit(OrdersError(failure.errMessage)),
      (order) => emit(OrderLoaded(order)),
    );
  }

  Future<void> _onFetchOrderDetails(
    FetchOrderDetails event,
    Emitter<OrdersState> emit,
  ) async {
    emit(OrdersLoading());
    final Either<Failure, Orderr> result = await getOrderDetails(event.id);
    result.fold(
      (failure) => emit(OrdersError(failure.errMessage)),
      (order) => emit(OrderLoaded(order)),
    );
  }

  Future<void> _onFetchOrdersByCustomer(
    FetchOrdersByCustomer event,
    Emitter<OrdersState> emit,
  ) async {
    emit(OrdersLoading());
    final Either<Failure, List<Orderr>> result = await getOrdersByCustomer();
    result.fold(
      (failure) => emit(OrdersError(failure.errMessage)),
      (orders) => emit(OrdersListLoaded(orders)),
    );
  }

  Future<void> _onFetchOrdersByCustomerAndStatus(
    FetchOrdersByCustomerAndStatus event,
    Emitter<OrdersState> emit,
  ) async {
    emit(OrdersLoading());
    final Either<Failure, List<Orderr>> result =
        await getOrdersByCustomerAndStatus(event.clientId, event.status);
    result.fold(
      (failure) => emit(OrdersError(failure.errMessage)),
      (orders) => emit(OrdersListLoaded(orders)),
    );
  }
}
