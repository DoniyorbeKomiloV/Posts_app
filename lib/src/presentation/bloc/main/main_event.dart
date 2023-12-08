part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();
}

class MainEventChanged extends MainEvent {
  const MainEventChanged(this.menu);

  final BottomMenu menu;

  @override
  List<Object?> get props => [menu];
}

class SaveUserInfo extends MainEvent {
  const SaveUserInfo(
      {required this.name, required this.password, required this.login});

  final String name;
  final String password;
  final String login;

  @override
  List<Object?> get props => [
        name,
        password,
        login,
      ];
}
