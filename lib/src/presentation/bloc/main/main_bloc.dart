import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/src/data/source/local_source.dart';
import 'package:posts_app/src/domain/repositories/home/home_repository.dart';

part 'main_state.dart';

part 'main_event.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainState()) {
    on<MainEventChanged>(_onChangeMenu);
    on<SaveUserInfo>(_saveUserInfo);
  }
  HomeRepository homeRepository = HomeRepositoryImpl(dio: Dio());
  final LocalSource localSource = LocalSource();
  void _onChangeMenu(MainEventChanged event, Emitter<MainState> emit) {
    emit(state.copyWith(bottomMenu: event.menu));
  }

  void _saveUserInfo(SaveUserInfo event, Emitter<MainState> emit) async {
    emit(state.copyWith(userStatus: UserStatus.loading));

    final result = await homeRepository.saveUserInfo(
      request: {
        "name": event.name,
        "password": event.password,
        "login": event.login,
      },
      id: localSource.userId,
    );

    result.fold(
      (l) {
        emit(state.copyWith(userStatus: UserStatus.error));
      },
      (r) {
        emit(state.copyWith(userStatus: UserStatus.succes));
        localSource.setUser(
            login: r.login, password: r.password, name: r.name, userId: r.id);
        add(const MainEventChanged(BottomMenu.home));
      },
    );
  }
}

enum BottomMenu {
  home,
  profile,
}
