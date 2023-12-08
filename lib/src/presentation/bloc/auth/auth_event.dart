part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthEventInitial extends AuthEvent {
  const AuthEventInitial();

  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  const LoginEvent({
    required this.login,
    required this.password,
  });

  final String login;
  final String password;

  @override
  List<Object?> get props => [
        login,
        password,
      ];
}

class RegisterEvent extends AuthEvent {
  const RegisterEvent({
    required this.name,
    required this.password,
    required this.login,
  });

  final String name;
  final String login;
  final String password;

  @override
  List<Object?> get props => [
        name,
        password,
        login,
      ];
}
