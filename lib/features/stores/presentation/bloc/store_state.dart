import 'package:equatable/equatable.dart';
import 'package:smartcare/features/stores/domain/entities/store_entity.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object?> get props => [];
}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}

class StoreLoaded extends StoreState {
  final List<StoreEntity> stores;
  const StoreLoaded(this.stores);

  @override
  List<Object?> get props => [stores];
}

class StoreError extends StoreState {
  final String message;
  const StoreError(this.message);

  @override
  List<Object?> get props => [message];
}

class NearestStoreLoaded extends StoreState {
  final StoreEntity store;
  const NearestStoreLoaded(this.store);
}

class NearestStoreError extends StoreState {
  final String message;
  const NearestStoreError(this.message);
}
