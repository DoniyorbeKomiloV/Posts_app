part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitialState extends AuthState {
  const AuthInitialState();

  @override
  List<Object?> get props => [];
}

class AuthSuccessState extends AuthState {
  const AuthSuccessState();

  @override
  List<Object?> get props => [];
}

class AuthLoginState extends AuthState {
  const AuthLoginState();

  @override
  List<Object?> get props => [];
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState();

  @override
  List<Object?> get props => [];
}

class AuthErrorState extends AuthState {
  const AuthErrorState({
    required this.error,
  });
  final String error;
  @override
  List<Object?> get props => [error];
}

class UserRegisterSuccessState extends AuthState {
  const UserRegisterSuccessState();

  @override
  List<Object?> get props => [];
}
