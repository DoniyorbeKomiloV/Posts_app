import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/src/data/models/auth/login/login_response.dart';
import 'package:posts_app/src/data/source/local_source.dart';
import '../../../domain/repositories/auth/auth_repository.dart';

part 'auth_state.dart';

part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitialState()) {
    on<LoginEvent>(login);
    on<RegisterEvent>(register);
  }

  final LocalSource localSource = LocalSource();
  final AuthRepository authRepository = AuthRepositoryImpl(dio: Dio());

  Future<void> login(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoadingState());

    final result = await authRepository.login();
    result.fold(
      (l) {
        emit(const AuthErrorState(error: 'Something went wrong'));
      },
      (r) {
        bool isSucces = false;
        for (UserResponse user in r) {
          if (user.login == event.login) {
            if (user.password == event.password) {
              localSource.setUser(
                name: user.name,
                password: user.password,
                login: user.login,
                userId: user.id,
              );
              emit(const AuthSuccessState());
            } else {
              emit(const AuthErrorState(error: 'Password is wrong'));
            }

            isSucces = true;
            break;
          }
        }
        if (!isSucces) {
          emit(const AuthLoginState());
        }
      },
    );
  }

  Future<void> register(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoadingState());
    final result = await authRepository.registerUser(request: {
      'name': event.name,
      'password': event.password,
      'login': event.login,
    });
    result.fold(
      (l) {
        emit(const AuthErrorState(error: 'Something went wrong'));
      },
      (r) {
        emit(const UserRegisterSuccessState());
      },
    );
  }
}
