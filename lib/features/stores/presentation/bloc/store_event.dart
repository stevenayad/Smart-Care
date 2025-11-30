import 'package:equatable/equatable.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object?> get props => [];
}

class FetchStoresEvent extends StoreEvent {}

class SearchStores extends StoreEvent {
  final String query;
  SearchStores(this.query);

  @override
  List<Object?> get props => [query];
}

class CallStore extends StoreEvent {
  final String phoneNumber;
  CallStore(this.phoneNumber);
}

class OpenDirections extends StoreEvent {
  final double latitude;
  final double longitude;
  OpenDirections(this.latitude, this.longitude);
}

class GetNearestStore extends StoreEvent {
  final double latitude;
  final double longitude;

  const GetNearestStore(this.latitude, this.longitude);
}
