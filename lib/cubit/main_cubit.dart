import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainState());

  void initialize() async {}

  void openMenu() {
    emit(state.copyWith(showMenu: true));
  }

  void closeMenu() {
    emit(state.copyWith(beginCloseMenu: true));
    Future.delayed(const Duration(milliseconds: 500), () {
      emit(state.copyWith(showMenu: false, beginCloseMenu: false));
    });
  }
}
