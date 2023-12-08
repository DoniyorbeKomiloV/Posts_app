part of 'main_bloc.dart';

class MainState extends Equatable {
  const MainState({
    this.bottomMenu = BottomMenu.home,
    this.userStatus = UserStatus.initial,
  });

  final BottomMenu bottomMenu;
  final UserStatus userStatus;

  MainState copyWith({
    BottomMenu? bottomMenu,
    UserStatus? userStatus,
  }) =>
      MainState(
        bottomMenu: bottomMenu ?? this.bottomMenu,
        userStatus: userStatus ?? UserStatus.initial,
      );

  @override
  List<Object?> get props => [
        bottomMenu,
        userStatus,
      ];
}

enum UserStatus { initial, loading, error, succes }
