import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare/features/home/data/Repo/details_signalr.dart';

part 'signalrdetials_state.dart';

class SignalrdetialsCubit extends Cubit<SignalrdetialsState> {
  final DetailsSignalRService signalRService;

  SignalrdetialsCubit(this.signalRService) : super(SignalrdetialsInitial());

  void initGlobalListener() async {
    await signalRService.connect();
    signalRService.listenReservationExpired((model) {
      emit(SignalrdetialsUpdated(model));
      print("🔥 EVENT RECEIVED: ${model.productId}");
    });
  }

  Future<void> joinProduct(String productId) async {
    await signalRService.joinProductGroup(productId);
  }
}
