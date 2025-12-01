import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare/features/home/data/Repo/details_signalr.dart';

part 'signalrdetials_state.dart';

class SignalrdetialsCubit extends Cubit<SignalrdetialsState> {
  final DetailsSignalRService signalRService;

  SignalrdetialsCubit(this.signalRService) : super(SignalrdetialsInitial());

  void initListener(String productid) async {
    await signalRService.connect();
    await signalRService.joinProductGroup(productid);
    signalRService.listenReservationExpired((model) {
      emit(SignalrdetialsUpdated(model));
    });
  }
}
