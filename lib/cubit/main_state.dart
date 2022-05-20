part of 'main_cubit.dart';

class MainState {
  bool showMenu;
  bool beginCloseMenu;

  MainState({
    this.showMenu = false,
    this.beginCloseMenu = false,
  });

  MainState copyWith({
    bool? showMenu,
    bool? beginCloseMenu,
  }) {
    return MainState(
      showMenu: showMenu ?? this.showMenu,
      beginCloseMenu: beginCloseMenu ?? this.beginCloseMenu,
    );
  }
}
