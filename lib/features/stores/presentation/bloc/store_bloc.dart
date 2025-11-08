import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/stores/domain/entities/store_entity.dart';
import 'package:smartcare/features/stores/domain/repositories/store_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'store_event.dart';
import 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final StoreRepository repository;

  List<StoreEntity> _allStores = [];
  StoreBloc(this.repository) : super(StoreInitial()) {
    on<FetchStoresEvent>(_onFetchStores);
    on<SearchStores>(_onSearchStores);
    on<CallStore>(_onCallStore);
    on<OpenDirections>(_onOpenDirections);
  }

  Future<void> _onFetchStores(
    FetchStoresEvent event,
    Emitter<StoreState> emit,
  ) async {
    emit(StoreLoading());
    final result = await repository.getStores();
    result.fold((failure) => emit(StoreError(failure.errMessage)), (stores) {
      _allStores = stores;
      emit(StoreLoaded(stores));
    });
  }

  void _onSearchStores(SearchStores event, Emitter<StoreState> emit) {
    if (_allStores.isEmpty) return;

    final query = event.query.toLowerCase().trim();

    if (query.isEmpty) {
      emit(StoreLoaded(_allStores));
      return;
    }

    final filteredStores = _allStores.where((store) {
      return store.name.toLowerCase().contains(query) ||
          store.address.toLowerCase().contains(query) ||
          store.phone.toLowerCase().contains(query);
    }).toList();

    emit(StoreLoaded(filteredStores));
  }

  Future<void> _onCallStore(CallStore event, Emitter<StoreState> emit) async {
    final Uri url = Uri(scheme: 'tel', path: event.phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  Future<void> _onOpenDirections(
    OpenDirections event,
    Emitter<StoreState> emit,
  ) async {
    final Uri googleMapUri = Uri.parse(
      "geo:${event.latitude},${event.longitude}?q=${event.latitude},${event.longitude}",
    );
    final Uri fallbackUri = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=${event.latitude},${event.longitude}",
    );
    if (await canLaunchUrl(googleMapUri)) {
      await launchUrl(googleMapUri, mode: LaunchMode.externalApplication);
    } else if (await canLaunchUrl(fallbackUri)) {
      await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch map for ${event.latitude},${event.longitude}';
    }
  }
}
