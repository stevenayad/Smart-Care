import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';



class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0); 

  void changeIndex(int index) => emit(index);
}
